import asyncio

import temporalio.workflow
import datetime
from .activity import say_hello_activity


@temporalio.workflow.defn
class TestWorkflow:
    name = "TestWorkflow"

    @temporalio.workflow.run
    async def run(self) -> str:
        tasks = []
        for i in range(10*1000):
            tasks.append(temporalio.workflow.execute_activity(
                say_hello_activity,
                "john 1",
                schedule_to_close_timeout=datetime.timedelta(seconds=60),
            ))

        results = await asyncio.gather(*tasks)

        return str(results)

