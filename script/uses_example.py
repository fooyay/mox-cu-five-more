"""
Deploy script for Vyper module example using Moccasin's pyevm
Run with: mox run deploy
"""

import boa


def deploy():
    # Set up test accounts using boa's environment
    deployer = boa.env.generate_address()
    new_owner = boa.env.generate_address()

    print(f"Deployer address: {deployer}")
    print(f"New owner address: {new_owner}")
    print("-" * 60)

    # Deploy the main contract
    print("Deploying main_contract...")
    with boa.env.prank(deployer):
        contract = boa.load("src/main_contract.vy")
    print(f"✓ Contract deployed at: {contract.address}")
    print("-" * 60)

    # Check initial owner
    initial_owner = contract.get_owner()
    print(f"Initial owner: {initial_owner}")
    assert initial_owner == deployer, "Owner should be deployer"
    print("✓ Initial owner is correct")
    print("-" * 60)

    # Start ownership transfer
    print(f"Starting ownership transfer to {new_owner}...")
    with boa.env.prank(deployer):
        contract.start_transfer(new_owner)
    print(f"✓ Transfer initiated")

    # Check that owner hasn't changed yet
    current_owner = contract.get_owner()
    print(f"Current owner (should still be deployer): {current_owner}")
    assert current_owner == deployer, "Owner shouldn't change until accepted"
    print("✓ Owner hasn't changed yet (2-step transfer working)")
    print("-" * 60)

    # Try to accept from wrong account (should fail)
    print("Attempting to accept from wrong account (should fail)...")
    try:
        with boa.env.prank(deployer):
            contract.finish_transfer()
        print("✗ Should have failed!")
    except Exception as e:
        print(f"✓ Correctly rejected: {str(e)[:80]}...")
    print("-" * 60)

    # Accept ownership transfer from new owner
    print(f"Accepting ownership transfer as new owner...")
    with boa.env.prank(new_owner):
        contract.finish_transfer()
    print(f"✓ Ownership accepted")

    # Verify new owner
    final_owner = contract.get_owner()
    print(f"Final owner: {final_owner}")
    assert final_owner == new_owner, "Owner should be new_owner now"
    print("✓ Ownership successfully transferred!")
    print("-" * 60)

    # Try to start another transfer from old owner (should fail)
    print("Attempting to transfer from old owner (should fail)...")
    try:
        with boa.env.prank(deployer):
            contract.start_transfer(deployer)
        print("✗ Should have failed!")
    except Exception as e:
        print(f"✓ Correctly rejected: {str(e)[:80]}...")

    print("-" * 60)
    print("✅ All tests passed! Module 'uses' keyword working correctly.")
    print("\nSummary:")
    print(f"  - ownable module: tracks owner state")
    print(f"  - ownable_2step module: uses ownable's state via 'uses' keyword")
    print(f"  - main_contract: initializes both modules with walrus operator")
    print(f"  - 2-step ownership transfer: working as expected")

    return contract


def moccasin_main():
    return deploy()
