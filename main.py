from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from database import engine, Base, AsyncSessionLocal
from schemas import TaskCreate, Task
from services import create_task, get_tasks,get_task_by_id ,delete_task,update_task

app = FastAPI(title="Task Manager with SQLite")

# Create tables automatically
@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

# Dependency
async def get_db():
    async with AsyncSessionLocal() as session:
        yield session

@app.post("/tasks")
async def add_task(task: TaskCreate, db: AsyncSession = Depends(get_db)):
    return await create_task(db, task)

@app.get("/tasks")
async def list_tasks(db: AsyncSession = Depends(get_db)):
    return await get_tasks(db)

@app.get("/tasks/{task_id}", response_model=Task)
async def get_task(
    task_id: int,
    db: AsyncSession = Depends(get_db)
):
    return await get_task_by_id(db, task_id)

@app.put("/tasks/{task_id}", response_model=Task)
async def update_task_endpoint(
    task_id: int,
    task: TaskCreate,
    db: AsyncSession = Depends(get_db)
):
    return await update_task(db, task_id, task)

@app.delete("/tasks/{task_id}")
async def remove_task(task_id: int, db: AsyncSession = Depends(get_db)):
    success = await delete_task(db, task_id)
    if not success:
        raise HTTPException(status_code=404, detail="Task not found")
    return {"message": "Deleted"}
