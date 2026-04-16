from typing import Dict, Any
from schemas import UserCreate, Gender, ActivityLevel, Goal

# ---------------------------------------------------------
# Caloric Macros Constants (Kcal per gram)
# ---------------------------------------------------------
PROTEIN_KCAL = 4
FAT_KCAL = 9
CARB_KCAL = 4

def calculate_advanced_macros(user_data: UserCreate) -> Dict[str, int]:
    """
    Calculates TDEE and target macros based on the Mifflin-St Jeor equation,
    adjusted dynamically according to user goals, medical conditions, and realistic caps.
    """
    # 1. Calculate BMR (Mifflin-St Jeor)
    # Equation: (10 × weight_kg) + (6.25 × height_cm) - (5 × age) + S
    base_bmr = (10 * user_data.weight_kg) + (6.25 * user_data.height_cm) - (5 * user_data.age)
    
    if user_data.gender == Gender.male:
        bmr = base_bmr + 5
    elif user_data.gender == Gender.female:
        bmr = base_bmr - 161
    else:
        # Conservative average for "other" genders
        bmr = base_bmr - 78
        
    # 2. Activity Multiplier
    activity_multipliers = {
        ActivityLevel.sedentary: 1.2,
        ActivityLevel.light: 1.375,
        ActivityLevel.moderate: 1.55,
        ActivityLevel.active: 1.725,
        ActivityLevel.very_active: 1.9
    }
    multiplier = activity_multipliers.get(user_data.activity_level, 1.2)
    tdee = bmr * multiplier
    
    # 3. Goal Adjustments
    target_calories = tdee
    if user_data.goal == Goal.cut:
        target_calories = tdee - 500
    elif user_data.goal == Goal.bulk:
        target_calories = tdee + 300
    elif user_data.goal == Goal.lean_physique:
        target_calories = tdee - 200
        
    # Safety Check: Never let target calories drop into starvation mode
    target_calories = max(target_calories, 1200)

    # 4. Protein Calculation
    # Capped realism: Using target_weight_kg instead of current weight_kg to prevent 
    # recommending impossible massive protein volumes for overweight users.
    target_protein_g = 2.0 * user_data.target_weight_kg
    protein_calories = target_protein_g * PROTEIN_KCAL
    
    # 5. Fats Calculation (25% of Target Calories)
    fats_calories = target_calories * 0.25
    target_fats_g = fats_calories / FAT_KCAL
    
    # 6. Carbs Calculation (Remaining Calories)
    remaining_calories = target_calories - protein_calories - fats_calories
    # Safety check: Prevent carbs from hitting zero or going negative on aggressive cuts
    target_carbs_g = max(50, remaining_calories / CARB_KCAL) 
    
    # Recalculate exact final calories in case our safety caps (like the 50g carb floor) altered the math
    final_calories = (target_protein_g * PROTEIN_KCAL) + (target_fats_g * FAT_KCAL) + (target_carbs_g * CARB_KCAL)
    
    # 7. Fiber & Water Adjustments
    target_fiber_g = 25
    medical_lower = [cond.lower() for cond in user_data.medical_conditions]
    if 'diabetes' in medical_lower or 'pcos' in medical_lower:
        target_fiber_g = 35
        
    target_water_ml = 3000
    if user_data.weight_kg > 80 or user_data.activity_level in [ActivityLevel.active, ActivityLevel.very_active]:
        target_water_ml += 500

    # 8. Return safely formatted output
    return {
        "target_calories": int(round(final_calories)),
        "target_protein_g": int(round(target_protein_g)),
        "target_fats_g": int(round(target_fats_g)),
        "target_carbs_g": int(round(target_carbs_g)),
        "target_fiber_g": target_fiber_g,
        "target_water_ml": target_water_ml
    }
