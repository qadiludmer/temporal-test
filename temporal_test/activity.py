import time

from temporalio import activity


@activity.defn(name="say_hello_activity")
async def say_hello_activity(name: str) -> str:
    time.sleep(5)
    print("yay")
    return f"Hello, {name}!"

