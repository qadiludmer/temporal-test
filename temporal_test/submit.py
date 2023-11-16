import asyncio
import random
import string

from temporal_test.workflows import TestWorkflow
from temporalio.client import Client
from temporal_test.config import Config


async def main():
    client = await Client.connect("localhost:7233")

    workflow_id = "".join(
        random.choices(string.ascii_uppercase + string.digits, k=30)
    )

    for i in range(10):
        result = await client.execute_workflow(
            TestWorkflow.name, id=workflow_id, task_queue=Config.queue
        )

        print(result)


if __name__ == "__main__":
    asyncio.run(main())
