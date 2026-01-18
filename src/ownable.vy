# ownable.vy

owner: address

@deploy
def __init__():
    self.owner = msg.sender

def _check_owner():
    assert self.owner == msg.sender

@pure
def _times_two(x: uint256) -> uint256:
    return x * 2

@external
def update_owner(new_owner: address):
    self._check_owner()

    self.owner = new_owner