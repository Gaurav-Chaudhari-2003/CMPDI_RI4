from app.core.security import hash_password, verify_password

pw = "MySecret123"

hashed = hash_password(pw)
print("HASH:", hashed)

print("VALID:", verify_password(pw, hashed))
print("INVALID:", verify_password("wrong", hashed))
from app.core.security import hash_password
print(hash_password("1234"))
