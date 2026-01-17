# pragma version 0.4.3
# @license MIT

import favorites 


initializes: favorites

@deploy
def __init__():
    favorites.__init__()



# my_favorite_number: uint256

# @external
# def store(new_number: uint256):
#     self.my_favorite_number = new_number