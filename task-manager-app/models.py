from sqlalchemy import Column,String,Integer
from database import Base

class TaskModel(Base):
    __tablename__="tasks"

    id = Column(Integer, primary_key=True, index=True)
    title =Column(String, index=True)
    description = Column(String)
    hours =Column(Integer)
    priority=Column(String)
