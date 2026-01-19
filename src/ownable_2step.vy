# ownable_2step.vy
from . import ownable

uses: ownable

# does not export ownable.transfer_ownership!

pending_owner: address  # the pending owner in the 2-step transfer process

@deploy
def __init__():
    self.pending_owner = empty(address)

@internal
def transfer_ownership(new_owner: address):
    ownable._check_owner()

    self.pending_owner = new_owner

@internal
def accept_ownership():
    assert msg.sender == self.pending_owner

    ownable.owner = msg.sender
    self.pending_owner = empty(address)