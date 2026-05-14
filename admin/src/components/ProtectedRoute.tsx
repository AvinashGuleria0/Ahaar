import React, { useEffect, useState } from 'react';
import { Navigate } from 'react-router-dom';
import { supabase } from '../lib/supabaseClient';

export default function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null);
  const [isAdmin, setIsAdmin] = useState<boolean | null>(null);

  useEffect(() => {
    const verifyAccess = async () => {
      // 1. Check if user is logged into Supabase Auth
      const { data: { session }, error: sessionError } = await supabase.auth.getSession();
      
      if (sessionError || !session) {
        setIsAuthenticated(false);
        return;
      }
      
      setIsAuthenticated(true);

      // 2. Query our public.users table to verify is_admin flag
      const { data: userRecord, error: userError } = await supabase
        .from('users')
        .select('is_admin')
        .eq('id', session.user.id)
        .single();

      if (userError || !userRecord || userRecord.is_admin !== true) {
        setIsAdmin(false);
      } else {
        setIsAdmin(true);
      }
    };

    verifyAccess();
  }, []);

  // Show a blank loading screen while verifying the session and database
  if (isAuthenticated === null) {
    return <div className="flex min-h-screen items-center justify-center bg-gray-50 text-indigo-600">Authenticating Session...</div>;
  }

  // If not logged in, bounce to Login page
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  // If logged in but not an admin, display an Access Denied splash screen
  if (isAdmin === false) {
    return (
      <div className="flex min-h-screen flex-col items-center justify-center bg-gray-50">
        <h1 className="text-4xl font-black text-red-600 mb-4">ACCESS DENIED</h1>
        <p className="text-gray-600 text-lg mb-8">You do not have administrative privileges for the Aahar portal.</p>
        <button 
          onClick={async () => {
            await supabase.auth.signOut();
            window.location.href = '/login';
          }}
          className="rounded-lg bg-indigo-600 px-6 py-3 font-bold text-white hover:bg-indigo-700"
        >
          Sign Out & Return to Login
        </button>
      </div>
    );
  }

  // If both authenticated and isAdmin == true, render the protected page
  return <>{children}</>;
}
