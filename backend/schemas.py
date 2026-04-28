from pydantic import BaseModel, Field, ConfigDict
from enum import Enum
from typing import List, Optional
from uuid import UUID
from datetime import datetime, date

# ---------------------------------------------------------
# Strictly Typed Enums (Mirroring SQL CHECK Constraints)
# ---------------------------------------------------------

class MealType(str, Enum):
    breakfast = 'breakfast'
    lunch = 'lunch'
    snack = 'snack'
    dinner = 'dinner'
    dessert = 'dessert'
    late_night = 'late_night'

class Gender(str, Enum):
    male = 'male'
    female = 'female'
    other = 'other'

class ActivityLevel(str, Enum):
    sedentary = 'sedentary'
    light = 'light'
    moderate = 'moderate'
    active = 'active'
    very_active = 'very_active'

class Goal(str, Enum):
    cut = 'cut'
    maintain = 'maintain'
    bulk = 'bulk'
    lean_physique = 'lean_physique'

class DietPreference(str, Enum):
    veg = 'veg'
    non_veg = 'non_veg'
    eggetarian = 'eggetarian'
    vegan = 'vegan'
    jain = 'jain'
    any = 'any'

class RegionPreference(str, Enum):
    north_indian = 'north_indian'
    south_indian = 'south_indian'
    east_indian = 'east_indian'
    west_indian = 'west_indian'
    any = 'any'

class DailyBudgetTier(str, Enum):
    low = 'low'
    medium = 'medium'
    high = 'high'
    premium = 'premium'

class SugarPreference(str, Enum):
    strict_no_sugar = 'strict_no_sugar'
    moderate_sugar = 'moderate_sugar'
    no_restriction = 'no_restriction'

# ---------------------------------------------------------
# Pydantic Schemas
# ---------------------------------------------------------

class UserBase(BaseModel):
    """
    Base user properties shared across multiple schemas.
    """
    name: str = Field(..., description="User's full name")
    gender: Gender
    age: int = Field(..., gt=0, description="User's age, must be greater than 0")
    
    # Body Metrics
    weight_kg: float = Field(..., gt=0)
    target_weight_kg: float = Field(..., gt=0)
    height_cm: float = Field(..., gt=0)
    activity_level: ActivityLevel
    goal: Goal
    
    # Advanced Dietary Context
    diet_preference: DietPreference = Field(default=DietPreference.any)
    region_preference: RegionPreference = Field(default=RegionPreference.any)
    daily_budget_tier: DailyBudgetTier = Field(default=DailyBudgetTier.medium)
    sugar_preference: SugarPreference = Field(default=SugarPreference.moderate_sugar)
    meals_per_day: int = Field(default=3, gt=0, le=6, description="Meals per day (1-6)")
    
    # Health & Medical
    allergies: List[str] = Field(default_factory=list, description="List of food allergies")
    medical_conditions: List[str] = Field(default_factory=list, description="List of medical conditions")


class UserCreate(UserBase):
    """
    Payload for creating a new profile.
    Notice that id, auth_id, and computed macros are purposefully omitted.
    auth_id will be extracted securely from the JWT token in the API route.
    """
    pass


class UserResponse(UserBase):
    """
    Response model when fetching or successfully creating a user.
    Includes database-generated IDs and AI-calculated targets.
    """
    id: UUID
    auth_id: UUID
    
    # Calculated targets (Updated by the AI Engine)
    target_calories: int
    target_protein_g: int
    target_carbs_g: int
    target_fats_g: int
    target_fiber_g: int = 25
    target_water_ml: int = 3000
    
    created_at: datetime
    
    # Pydantic v2 configuration to allow parsing from ORM/dictionaries easily
    model_config = ConfigDict(from_attributes=True)

# ---------------------------------------------------------
# Daily Log & Meal Schemas (Phase 2)
# ---------------------------------------------------------

class MealLogRequest(BaseModel):
    """
    Payload sent from Flutter to log a new meal.
    Contains total macros that will be added to the daily running totals,
    as well as recorded specifically to the meal instance.
    """
    user_id: UUID
    log_date: date
    meal_type: MealType
    
    # All macros default to 0.0 purely for safety if a user logs just water or zero-calorie foods
    meal_calories: float = Field(default=0.0, ge=0.0)
    meal_protein_g: float = Field(default=0.0, ge=0.0)
    meal_carbs_g: float = Field(default=0.0, ge=0.0)
    meal_fats_g: float = Field(default=0.0, ge=0.0)
    meal_fiber_g: float = Field(default=0.0, ge=0.0)
    meal_sugar_g: float = Field(default=0.0, ge=0.0)
    meal_sodium_mg: float = Field(default=0.0, ge=0.0)

class MealLogResponse(BaseModel):
    """
    Clean, perfectly-typed JSON object sent back to Flutter after a successful save.
    Represents the inserted row in the 'meals' table.
    """
    id: UUID
    daily_log_id: UUID
    meal_type: MealType
    logged_at: datetime
    
    # Based on your SQL constraint, only these macros are saved to the specific 'meal' row natively
    meal_calories: float
    meal_protein_g: float
    
    model_config = ConfigDict(from_attributes=True)

class DailyLogResponse(BaseModel):
    """
    Represents the running totals for a specific user on a specific day.
    Matches the 'daily_logs' table in Supabase.
    """
    id: UUID
    user_id: UUID
    log_date: date
    
    consumed_calories: float
    consumed_protein_g: float
    consumed_carbs_g: float
    consumed_fats_g: float
    consumed_fiber_g: float
    consumed_sugar_g: float
    consumed_sodium_mg: float
    water_ml: int
    
    model_config = ConfigDict(from_attributes=True)

class MealLogSuccessResponse(BaseModel):
    """
    Comprehensive response confirming a meal was saved and returning the new daily totals.
    """
    message: str
    meal: MealLogResponse
    daily_totals: DailyLogResponse

class TextLogRequest(BaseModel):
    """
    Payload for text or voice-based meal logging entries.
    """
    text: str

class WeightUpdateRequest(BaseModel):
    weight_kg: float = Field(..., gt=20, lt=300)

class WorkoutLogRequest(BaseModel):
    user_id: UUID
    date: date
    exercise_name: str
    sets_completed: int = Field(..., ge=0)
    target_sets: int = Field(..., gt=0)
    completed_sets_json: List[dict] = Field(default_factory=list)

class WorkoutLogBulkRequest(BaseModel):
    logs: List[WorkoutLogRequest]

