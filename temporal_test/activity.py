from temporalio import activity


@activity.defn(name="say_hello_activity")
async def say_hello_activity(name: str) -> str:
    return f"Hello, {name}!"

