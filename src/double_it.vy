# pragma version 0.4.3
# @license MIT


my_doubled_number: uint256



@deploy
def __init__():
    self.my_doubled_number = 2

@external
def double_store(new_number: uint256):
    self.my_doubled_number = new_number * 2

@external
@view
def double_retrieve() -> uint256:
    return self.my_doubled_number

