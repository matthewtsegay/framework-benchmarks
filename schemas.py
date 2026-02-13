from pydantic import BaseModel, Field,ConfigDict

class TaskCreate(BaseModel):
    title: str = Field(...,min_length=3)
    description: str
    hours: int = Field(..., gt=0)

class Task(TaskCreate):
    id: int
    priority: str

    model_config = ConfigDict(from_attributes=True) # allows SQLAlchemy objects to convert to JSON.
