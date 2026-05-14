-- Enable the pgvector extension if not already enabled
CREATE EXTENSION IF NOT EXISTS vector;

-- 1. Create the Universities Table
CREATE TABLE IF NOT EXISTS public.universities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    city TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Update existing Users table
-- (Assuming your users table is public.users or auth.users)
-- Add university_id to link students to their college
ALTER TABLE public.users 
ADD COLUMN IF NOT EXISTS university_id UUID REFERENCES public.universities(id) ON DELETE SET NULL;

-- 3. Create the University Meals Semantic Cache
CREATE TABLE IF NOT EXISTS public.university_meals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    university_id UUID NOT NULL REFERENCES public.universities(id) ON DELETE CASCADE,
    dish_name TEXT NOT NULL,
    default_weight_g FLOAT NOT NULL,
    calories FLOAT NOT NULL,
    protein_g FLOAT NOT NULL,
    carbs_g FLOAT NOT NULL,
    fats_g FLOAT NOT NULL,
    -- 2048 dimensions strictly for Qwen3-VL-Embedding-2B
    image_embedding vector(2048) NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Create indexes for blazing fast querying
-- Note: pgvector has a 2000 dimension limit for hnsw indexes.
-- Since Qwen3-VL is 2048 dimensions, we will use Exact Nearest Neighbor search (seq scan).
-- For a hyper-local university scope (<10,000 meals), exact search is still sub-millisecond.

-- Index university_id to quickly scope queries (This is critical for performance without a vector index)
CREATE INDEX IF NOT EXISTS university_meals_uni_idx 
ON public.university_meals(university_id);

-- 5. The Core RPC Function (Cosign Similarity Short-Circuit)
-- This function computes the Cosine Distance (<=>) and returns matches > 85% confidence
CREATE OR REPLACE FUNCTION match_university_meal_rpc(
    query_embedding vector(2048),
    user_university_id UUID,
    match_threshold FLOAT DEFAULT 0.85
)
RETURNS TABLE (
    id UUID,
    dish_name TEXT,
    default_weight_g FLOAT,
    calories FLOAT,
    protein_g FLOAT,
    carbs_g FLOAT,
    fats_g FLOAT,
    similarity FLOAT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        um.id,
        um.dish_name,
        um.default_weight_g,
        um.calories,
        um.protein_g,
        um.carbs_g,
        um.fats_g,
        1 - (um.image_embedding <=> query_embedding) AS similarity
    FROM public.university_meals um
    WHERE um.university_id = user_university_id
      -- Cosine distance operator (<=>). Similarity is 1 - distance.
      AND 1 - (um.image_embedding <=> query_embedding) > match_threshold
    ORDER BY um.image_embedding <=> query_embedding ASC
    LIMIT 1;
END;
$$;
