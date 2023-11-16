import temporalio.workflow
import datetime
from .activity import say_hello_activity


@temporalio.workflow.defn
class TestWorkflow:
    name = "TestWorkflow"

    @temporalio.workflow.run
    async def run(self) -> str:
        a = ""
        b = ""
        for i in range(10):
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
            print(i)

        return a+b

