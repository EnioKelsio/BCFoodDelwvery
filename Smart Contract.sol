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
 function createOffer(address producer, string memory name, uint weight, uint diameter, uint quality, uint pricePerKg) public payable {
        uint totalCost = weight * pricePerKg * 1e18;
        require(msg.value == totalCost, "Sent value must be equal to total cost of fruit");
