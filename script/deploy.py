from src import favorites, favorites_factory  # type: ignore
from moccasin.boa_tools import VyperContract  # type: ignore


def deploy_favorites() -> VyperContract:
    favorites_contract: VyperContract = favorites.deploy()
    print(f"Favorites contract deployed at: {favorites_contract.address}")
    return favorites_contract


def deploy_factory(favorites_contract: VyperContract) -> None:
    factory_contract: VyperContract = favorites_factory.deploy(favorites_contract.address)
    factory_contract.create_favorites_contract()

    new_favorites_address: str = factory_contract.list_of_favorite_contracts(0)
    new_favorites_contract: VyperContract = favorites.at(new_favorites_address)
    new_favorites_contract.store(77)
    retrieved_value: int = new_favorites_contract.retrieve()
    print(f"Retrieved value from new Favorites contract: {retrieved_value}")

    factory_contract.store_from_factory(0, 123)
    updated_value: int = new_favorites_contract.retrieve()
    print(f"Updated value from new Favorites contract: {updated_value}")
    print(f"Original contract stored value remains: {favorites_contract.retrieve()}")


def moccasin_main():
    favorites_contract = deploy_favorites()
    deploy_factory(favorites_contract)
