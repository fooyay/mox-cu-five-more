# pragma version 0.4.3
# @license MIT


from interfaces import i_favorites

list_of_favorite_contracts: public(DynArray[address, 100])
original_favorite_contract: address 

@deploy
def __init__(original_favorite_contract: address):
    self.original_favorite_contract = original_favorite_contract

@external
def create_favorites_contract():
    new_favorites_contract: address = create_copy_of(self.original_favorite_contract)
    self.list_of_favorite_contracts.append(new_favorites_contract)
