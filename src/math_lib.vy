# pragma version 0.4.3
# @license MIT

# A utility module with state that can be accessed via `uses`


# increment_value: public(uint256)

# @internal 
# def set_value(_val: uint256):
#     self.increment_value = _val

# @internal
# def add_increment(a: uint256) -> uint256:
#     return a + self.increment_value

# math_lib.vy


@internal
def times_two(a: uint256) -> uint256:
    return a * 2

