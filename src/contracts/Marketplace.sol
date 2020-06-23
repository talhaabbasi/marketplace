pragma solidity ^0.5.0;

contract Marketplace {
    string public name;
    uint256 public productCount = 0;

    mapping(uint256 => Product) public products;

    struct Product {
        uint256 id;
        string name;
        uint256 price;
        address payable owner;
        bool purchased;
    }

    event ProductCreated(
        uint256 id,
        string name,
        uint256 price,
        address payable owner,
        bool purchased
    );
    event ProductPurchased(
        uint256 id,
        string name,
        uint256 price,
        address payable owner,
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

    function purchaseProduct(uint256 _id) public payable {
        //Fetch the product
        Product memory _product = products[_id];
        //Fetch the owner
        address payable _seller = _product.owner;
        //Product is valid
        require(_product.id > 0 && _product.id <= productCount);
        // Have enough Ether
        require(msg.value >= _product.price);
        //The product has not been purchased
        require(!_product.purchased);
        //Buyer is not the seller
        require(_seller != msg.sender);
        // Purchase it
        _product.owner = msg.sender;
        // Mark as purchased
        _product.purchased = true;
        //Update the product
        products[_id] = _product;
        // Pay the seller by sending them Ether
        address(_seller).transfer(msg.value);
        //Trigger an Event
        emit ProductCreated(
            productCount,
            _product.name,
            _product.price,
            msg.sender,
            true
        );
    }
}
