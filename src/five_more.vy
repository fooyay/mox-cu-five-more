# pragma version 0.4.3
# @license MIT

import favorites 
import double_it
from . import math_lib

initializes: favorites
initializes: double_it

exports: (
    favorites.retrieve,
    favorites.add_person,
    double_it.double_store,
    double_it.double_retrieve
)


@deploy
def __init__():
    favorites.__init__()
    double_it.__init__()

@external
def store(new_number: uint256):
    # math_lib.set_value(2)
    favorites.my_favorite_number = math_lib.times_two(new_number)
