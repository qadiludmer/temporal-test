import asyncio

from temporalio.client import Client
from temporalio.worker import Worker
import temporalio.workflow
import datetime
from temporal_test.workload.activity import say_hello_activity

task_queue = "say-hello-task-queue"
workflow_name = "say-hello-workflow"
activity_name = "say-hello-activity"


@temporalio.workflow.defn
class BackgroundCheck:
    @temporalio.workflow.run
    async def run(self) -> str:
        a = await temporalio.workflow.execute_activity(
            say_hello_activity,
            "john 1",
            schedule_to_close_timeout=datetime.timedelta(seconds=5),
        )

        b = await temporalio.workflow.execute_activity(
            say_hello_activity,
            "john 2",
            schedule_to_close_timeout=datetime.timedelta(seconds=5),
        )

        return a+b


async def main():
    # Create client to localhost on default namespace
    client = await Client.connect("localhost:7233", namespace="default")

    worker = Worker(
        client,
        task_queue=task_queue,
        workflows=[BackgroundCheck],
        activities=[say_hello_activity],
    )

    await worker.run()


if __name__ == "__main__":
    asyncio.run(main())
