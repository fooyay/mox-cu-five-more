from . import ownable
from . import ownable_2step

initializes: ownable
initializes: ownable_2step[ownable := ownable]

@deploy
def __init__():
    ownable.__init__()
    ownable_2step.__init__()

@external
def start_transfer(new_owner: address):
    ownable_2step.transfer_ownership(new_owner)
    
@external
def finish_transfer():
    ownable_2step.accept_ownership()

@external
@view
def get_owner() -> address:
    return ownable.owner