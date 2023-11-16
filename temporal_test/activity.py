import asyncio
import random
import string

from temporalio import activity
from temporalio.client import Client
from temporalio.worker import Worker

task_queue = "say-hello-task-queue"
workflow_name = "say-hello-workflow"
activity_name = "say-hello-activity"


@activity.defn(name=activity_name)
async def say_hello_activity(name: str) -> str:
    return f"Hello, {name}!"

