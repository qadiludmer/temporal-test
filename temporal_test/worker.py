from temporalio.client import Client
from temporalio.worker import Worker
from temporal_test.activity import say_hello_activity
from temporal_test.config import Config
from temporal_test.workflows import TestWorkflow
import asyncio
import os


async def main():
    temporal_host = os.getenv("TEMPORAL_ADDRESS", "127.0.0.1:7233")
    print(f"connecting to temporal at {temporal_host}")

    client = await Client.connect(temporal_host, namespace="default")

    worker = Worker(
        client,
        task_queue=Config.queue,
        workflows=[TestWorkflow],
        activities=[say_hello_activity]
    )

    await worker.run()

print(__name__)

if __name__ == "temporal_test.worker":
    print("starting worker")
    asyncio.run(main())

if __name__ == "__main__":
    print("starting worker")
    asyncio.run(main())

