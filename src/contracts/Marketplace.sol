pragma solidity ^0.5.0;

contract Marketplace {
    string public name;
    uint256 public productCount = 0;

    mapping(uint256 => Product) public products;

    struct Product {
        uint256 id;
        string name;
        uint256 price;
        address owner;
        bool purchased;
    }

    event ProductCreated(
        uint256 id,
        string name,
        uint256 price,
        address owner,
        bool purchased
    );

    constructor() public {
        name = "Talha Abbasi's Marketplace";
    }

    function createProduct(string memory _name, uint256 _price) public {
        //Verify the product
        require(bytes(_name).length > 0);
        require(_price > 0);
        //Increment product count
        productCount++;
        //Create a product
        products[productCount] = Product(
            productCount,
            _name,
            _price,
            msg.sender,
            false
        );
        //Trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }
}
