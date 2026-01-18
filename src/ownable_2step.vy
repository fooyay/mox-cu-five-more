# ownable_2step.vy
import ownable

uses: ownable

# does not export ownable.transfer_ownership!

pending_owner: address  # the pending owner in the 2-step transfer process

@deploy
def __init__():
    self.pending_owner = empty(address)

@external
def begin_transfer(new_owner: address):
    ownable._check_owner()

    self.pending_owner = new_owner

@external
def accept_transfer(new_owner: address):
    assert msg.sender == self.pending_owner

    ownable.owner = new_owner
    self.pending_owner = empty(address)