import asyncio
import random
import string

from temporal_test.workload.activity import say_hello_activity
from temporalio.client import Client
from temporalio.worker import Worker

task_queue = "say-hello-task-queue"
workflow_name = "say-hello-workflow"
activity_name = "say-hello-activity"


async def main():
    # Create client to localhost on default namespace
    client = await Client.connect("localhost:7233")

    # Run activity worker
    async with Worker(client, task_queue=task_queue, activities=[say_hello_activity]):
        # Run the Go workflow
        workflow_id = "".join(
            random.choices(string.ascii_uppercase + string.digits, k=30)
        )
        result = await client.execute_workflow(
            "BackgroundCheck", id=workflow_id, task_queue=task_queue
        )
        # Print out "Hello, Temporal!"
        print(result)


if __name__ == "__main__":
    asyncio.run(main())
