import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

// Read .env manually to avoid needing a separate dotenv package in this script
const envPath = path.resolve(process.cwd(), '.env');
const envFile = fs.readFileSync(envPath, 'utf8');

let url = '';
let key = '';

envFile.split('\n').forEach(line => {
  if (line.startsWith('VITE_SUPABASE_URL=')) url = line.split('=')[1].trim();
  if (line.startsWith('VITE_SUPABASE_ANON_KEY=')) key = line.split('=')[1].trim();
});

const supabase = createClient(url, key);

async function run() {
  console.log("🚀 1. Resolving user admin@ahaar.com...");
  
  const email = 'admin@ahaar.com';
  const password = 'ahaaradmin'; 
  
  let userId = null;

  // Try logging in first
  const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
    email,
    password
  });

  if (signInData.user) {
    console.log("✅ User already exists! Retrieved UUID:", signInData.user.id);
    userId = signInData.user.id;
  } else {
    // If login failed, try signing up
    const { data: authData, error: authError } = await supabase.auth.signUp({
      email,
      password
    });

    if (authError) {
      console.error("❌ Auth Error:", authError.message);
      return;
    }
    console.log("✅ New Auth User created! UUID:", authData.user?.id);
    userId = authData.user?.id;
  }

  if (!userId) {
    console.error("❌ Cannot elevate: No UUID returned.");
    return;
  }

  console.log(`\n🛡️ 2. Attempting to elevate ${userId} to Administrator...`);
  
  // Attempt Upsert (Will likely fail due to RLS if using Anon key)
  const { data: updateData, error: updateError } = await supabase
    .from('users')
    .upsert({ id: userId, is_admin: true })
    .select();

  if (updateError) {
    console.error("\n❌ Database Error:", updateError.message);
    if (updateError.message.includes('row-level security policy') || updateError.message.includes('RLS')) {
      console.log("\n🛑 ROW LEVEL SECURITY (RLS) BLOCKED THE REQUEST!");
      console.log("Since this script uses the public ANON key, Supabase blocked it from modifying the users table.");
      console.log("\n✅ SOLUTION: Go to your Supabase SQL Editor and run this EXACT command to bypass RLS:");
      console.log("--------------------------------------------------");
      console.log(`INSERT INTO public.users (id, is_admin) VALUES ('${userId}', true) ON CONFLICT (id) DO UPDATE SET is_admin = true;`);
      console.log("--------------------------------------------------");
    }
  } else if (updateData && updateData.length > 0) {
    console.log("✅ Success! admin@ahaar.com is now an Admin!");
  } else {
    console.log("❌ Failed! Unknown database error.");
  }
}

run();
