# ownable.vy

owner: public(address)

@deploy
def __init__():
    self.owner = msg.sender

@internal
def _check_owner():
    assert self.owner == msg.sender, "Only owner can call this function"


