from app.core.security import create_access_token, decode_token

token = create_access_token("123", "EMP001")
print("TOKEN:", token)

data = decode_token(token)
print("DECODED:", data)
