# pragma version 0.4.3
# @license MIT

import favorites 
import double_it


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
    favorites.my_favorite_number = new_number + 5
