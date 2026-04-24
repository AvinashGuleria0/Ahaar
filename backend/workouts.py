from fastapi import APIRouter, Query

router = APIRouter()

WORKOUT_TEMPLATES = {
    "PPL": {
        "name": "PPL (Push/Pull/Legs)",
        "frequency": "6 days/week",
        "description": "Heavy compound lifts for maximum muscle growth.",
        "schedule": [
            {
                "day_name": "Push Day",
                "focus": "Chest, Shoulders, Triceps",
                "exercises": [
                    {"name": "Bench Press", "sets": 4, "reps": "8-10"},
                    {"name": "Incline Dumbbell Press", "sets": 3, "reps": "8-12"},
                    {"name": "Overhead Press", "sets": 3, "reps": "8-12"},
                    {"name": "Lateral Raises", "sets": 3, "reps": "12-15"},
                    {"name": "Tricep Pushdowns", "sets": 3, "reps": "10-15"}
                ]
            },
            {
                "day_name": "Pull Day",
                "focus": "Back, Biceps",
                "exercises": [
                    {"name": "Barbell Rows", "sets": 4, "reps": "8-10"},
                    {"name": "Lat Pulldown", "sets": 3, "reps": "10-12"},
                    {"name": "Face Pulls", "sets": 3, "reps": "12-15"},
                    {"name": "Bicep Curls", "sets": 3, "reps": "10-15"},
                    {"name": "Hammer Curls", "sets": 3, "reps": "10-12"}
                ]
            },
            {
                "day_name": "Legs Day",
                "focus": "Quads, Hamstrings, Calves",
                "exercises": [
                    {"name": "Squats", "sets": 4, "reps": "8-10"},
                    {"name": "Romanian Deadlift", "sets": 3, "reps": "8-10"},
                    {"name": "Leg Press", "sets": 3, "reps": "10-12"},
                    {"name": "Leg Extensions", "sets": 3, "reps": "12-15"},
                    {"name": "Leg Curl Machine", "sets": 3, "reps": "10-12"},
                    {"name": "Calf Raises", "sets": 4, "reps": "15-20"}
                ]
            }
        ]
    },
    "Full_Body": {
        "name": "Full Body Routine",
        "frequency": "3 days/week",
        "description": "Basic gym machines and dumbbells.",
        "schedule": [
            {
                "day_name": "Workout A",
                "focus": "Full Body",
                "exercises": [
                    {"name": "Goblet Squats", "sets": 3, "reps": "10-12"},
                    {"name": "Dumbbell RDL", "sets": 3, "reps": "10-12"},
                    {"name": "Machine Chest Press", "sets": 3, "reps": "10-12"},
                    {"name": "Seated Cable Row", "sets": 3, "reps": "10-12"},
                    {"name": "Dumbbell Bicep Curls", "sets": 3, "reps": "12-15"}
                ]
            },
            {
                "day_name": "Workout B",
                "focus": "Full Body",
                "exercises": [
                    {"name": "Leg Press", "sets": 3, "reps": "10-12"},
                    {"name": "Dumbbell Chest Fly", "sets": 3, "reps": "12-15"},
                    {"name": "Dumbbell Shoulder Press", "sets": 3, "reps": "10-12"},
                    {"name": "Lat Pulldown", "sets": 3, "reps": "10-12"},
                    {"name": "Tricep Extensions", "sets": 3, "reps": "12-15"}
                ]
            }
        ]
    },
    "Home_Bodyweight": {
        "name": "Home Bodyweight Routine",
        "frequency": "4 days/week",
        "description": "Pushups, squats, and yoga at home.",
        "schedule": [
            {
                "day_name": "Upper Body & Core",
                "focus": "Chest, Core",
                "exercises": [
                    {"name": "Pushups", "sets": 3, "reps": "AMRAP"},
                    {"name": "Plank", "sets": 3, "reps": "60 seconds"},
                    {"name": "Crunches", "sets": 3, "reps": "15-20"}
                ]
            },
            {
                "day_name": "Lower Body & Flexibility",
                "focus": "Legs, Yoga",
                "exercises": [
                    {"name": "Bodyweight Squats", "sets": 4, "reps": "15-20"},
                    {"name": "Lunges", "sets": 3, "reps": "12 each leg"},
                    {"name": "Downward Dog Hold", "sets": 2, "reps": "60 seconds"}
                ]
            }
        ]
    }
}

def recommend_workout(activity_level: str, goal: str):
    activity_level = activity_level.lower()
    goal = goal.lower()
    
    if activity_level in ['sedentary', 'light', 'light_active', 'lightly_active']:
        return WORKOUT_TEMPLATES['Home_Bodyweight']
    elif goal == 'bulk' and activity_level in ['active', 'very_active', 'very active']:
        return WORKOUT_TEMPLATES['PPL']
    else:
        return WORKOUT_TEMPLATES['Full_Body']

@router.get("/api/v1/workouts/recommend")
def get_workout_recommendation(activity_level: str = Query(...), goal: str = Query(...)):
    return recommend_workout(activity_level, goal)
