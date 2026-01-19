# calculate.vy
# pragma version 0.4.3
# @license MIT

from . import math_lib

uses: math_lib

result: public(uint256)

@external
def double_it(x: uint256) -> uint256:
    self.result = math_lib.times_two(x)
    return self.result
    
@external
@view
def show_count() -> uint256:
    return math_lib.get_counter()
     
 