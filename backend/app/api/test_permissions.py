from fastapi import APIRouter, Depends

from app.core.permissions import require_permission

router = APIRouter(prefix="/api/test", tags=["Permissions"])


@router.post("/create-booking")
def test_permission(
    user=Depends(require_permission("FTMS_CREATE_BOOKING")),
):
    return {"message": "Permission granted"}
