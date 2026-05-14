def predict_priority(hours: int) -> str:
    if hours >= 8:
        return "High"
    elif hours >= 4:
        return "Medium"
    return "Low"

