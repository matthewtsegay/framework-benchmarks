from sqlalchemy.future import select
from models import TaskModel
from utils import predict_priority
from sqlalchemy.ext.asyncio import AsyncSession
from fastapi import HTTPException
from schemas import TaskCreate

async def create_task(db, task_data):
    priority = predict_priority(task_data.hours)

    task = TaskModel(
        title=task_data.title,
        description=task_data.description,
        hours=task_data.hours,
        priority=priority
    )

    db.add(task)
    await db.commit()
    await db.refresh(task)
    return task

async def get_tasks(db):
    result = await db.execute(select(TaskModel))
    return result.scalars().all()

async def get_task_by_id(db: AsyncSession, task_id: int):
    result = await db.execute(select(TaskModel).where(TaskModel.id == task_id))
    task = result.scalar_one_or_none()

    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    return task

async def update_task(db: AsyncSession, task_id: int, task_data: TaskCreate):
    result = await db.execute(select(TaskModel).where(TaskModel.id == task_id))
    task = result.scalar_one_or_none()

    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    task.title = task_data.title
    task.description = task_data.description
    task.hours = task_data.hours

    await db.commit()
    await db.refresh(task)
    return task


async def delete_task(db: AsyncSession, task_id: int):
    result = await db.execute(select(TaskModel).where(TaskModel.id == task_id))
    task = result.scalar_one_or_none()

    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    await db.delete(task)
    await db.commit()

    return {"message": "Task deleted successfully"}
