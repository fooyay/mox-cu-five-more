# pragma version 0.4.3
# @license MIT

import favorites 
from . import math_lib

initializes: favorites

exports: (
    favorites.retrieve,
    favorites.add_person,
)


@deploy
def __init__():
    favorites.__init__()

@external
def store(new_number: uint256):
    favorites.my_favorite_number = math_lib.times_two(new_number)
