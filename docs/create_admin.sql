-- Create an Admin user with dummy data that EXACTLY matches the backend schemas.py
INSERT INTO public.users (
  id,
  auth_id,
  name,
  gender,
  age,
  weight_kg,
  target_weight_kg,
  height_cm,
  activity_level,
  goal,
  diet_preference,
  region_preference,
  daily_budget_tier,
  sugar_preference,
  meals_per_day,
  target_calories,
  target_protein_g,
  target_carbs_g,
  target_fats_g,
  is_admin
) VALUES (
  '7c74e85b-0ba4-4828-9597-bbd51637eda1', -- id
  '7c74e85b-0ba4-4828-9597-bbd51637eda1', -- auth_id
  'Ahaar Admin',                         -- name
  'male',                                -- gender
  30,                                    -- age
  70.0,                                  -- weight_kg
  70.0,                                  -- target_weight_kg
  175.0,                                 -- height_cm
  'moderate',                            -- activity_level
  'maintain',                            -- goal
  'any',                                 -- diet_preference
  'any',                                 -- region_preference
  'medium',                              -- daily_budget_tier
  'moderate_sugar',                      -- sugar_preference
  3,                                     -- meals_per_day
  2500,                                  -- target_calories
  150,                                   -- target_protein_g
  300,                                   -- target_carbs_g
  80,                                    -- target_fats_g
  true                                   -- is_admin
)
ON CONFLICT (id) 
DO UPDATE SET is_admin = true;
