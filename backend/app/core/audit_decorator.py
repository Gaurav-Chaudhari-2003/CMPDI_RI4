from functools import wraps
from fastapi import Request
from app.core.audit import log_action


def audit(action: str, entity_type: str = None):
    """
    Automatic audit logging decorator.

    Works for BOTH sync and async FastAPI endpoints.
    """

    def decorator(func):

        @wraps(func)
        async def async_wrapper(*args, **kwargs):
            request: Request = None
            user_id = None

            # Extract request from args
            for arg in args:
                if isinstance(arg, Request):
                    request = arg
                    break

            # Extract current user from kwargs
            if "current_user" in kwargs:
                user = kwargs["current_user"]
                user_id = getattr(user, "id", None)

            try:
                result = await func(*args, **kwargs)

                entity_id = None
                if isinstance(result, dict):
                    entity_id = result.get("id")

                log_action(
                    action=action,
                    user_id=user_id,
                    entity_type=entity_type,
                    entity_id=entity_id,
                    request=request,
                )

                return result

            except Exception as e:
                log_action(
                    action=f"{action}_FAILED",
                    user_id=user_id,
                    entity_type=entity_type,
                    description=str(e),
                    request=request,
                )
                raise

        @wraps(func)
        def sync_wrapper(*args, **kwargs):
            request: Request = None
            user_id = None

            for arg in args:
                if isinstance(arg, Request):
                    request = arg
                    break

            if "current_user" in kwargs:
                user = kwargs["current_user"]
                user_id = getattr(user, "id", None)

            try:
                result = func(*args, **kwargs)

                entity_id = None
                if isinstance(result, dict):
                    entity_id = result.get("id")

                log_action(
                    action=action,
                    user_id=user_id,
                    entity_type=entity_type,
                    entity_id=entity_id,
                    request=request,
                )

                return result

            except Exception as e:
                log_action(
                    action=f"{action}_FAILED",
                    user_id=user_id,
                    entity_type=entity_type,
                    description=str(e),
                    request=request,
                )
                raise

        # Detect if endpoint is async
        if hasattr(func, "__code__") and func.__code__.co_flags & 0x80:
            return async_wrapper
        return sync_wrapper

    return decorator
