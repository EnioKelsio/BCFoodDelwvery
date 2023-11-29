// SPDX-License-Identufier: GPL-3.0
pragma solidity ^0.8.17;

contract FruitMarket {
  address public owner_vendor;
  constructor() {
    owner_vendor = msg.sender;
}
 struct Fruit {
        string name;
        uint weight;
        uint diameter;
        uint quality;
        uint pricePerKg;
    }

    struct Offer {
        address vendor;
        Fruit fruit;
        uint quantity;
    }

    mapping(address => Offer[]) public offers;

 function createOffer(address producer, string memory name, uint weight, uint diameter, uint quality, uint pricePerKg) public payable {
        uint totalCost = weight * pricePerKg * 1e18;
        require(msg.value == totalCost, "Sent value must be equal to total cost of fruit");

        fruit memory fruit = Fruit(name, weight, diameter, quality, pricePerKg);
        Offer memory offer = Offer(msg.sender, fruit, weight);
        offers[producer].push(offer);
    }

    function acceptOffer() public {
        uint offerIndex = offers[msg.sender].length - 1;
        Offer storage offer = offers[msg.sender][offerIndex];

        // Transfer the funds to the producer
        payable(msg.sender).transfer(offer.fruit.weight * offer.fruit.pricePerKg * 1e18);

        // Remove the offer
        offers[msg.sender].pop();
    }

    function rejectOffer() public {
        uint offerIndex = offers[msg.sender].length - 1;
        Offer storage offer = offers[msg.sender][offerIndex];

        // Refund the funds to the vendor
        payable(offer.vendor).transfer(offer.fruit.weight * offer.fruit.pricePerKg * 1e18);

        // Remove the offer
        offers[msg.sender].pop();
    }
}
