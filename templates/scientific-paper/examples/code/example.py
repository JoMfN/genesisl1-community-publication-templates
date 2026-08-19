from hashlib import sha256

def commit(payload: bytes) -> str:
    return sha256(payload).hexdigest()
