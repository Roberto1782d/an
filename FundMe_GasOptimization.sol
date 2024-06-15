// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// 756,815
// 756,803 add constant to minimumusd 
// 736,858 change minimumusd to MINIMUM_USD

error NotOwner();


contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUN_USD = 50 * 1e18;
    // 2402 - non-constant
    // 303 - constant

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    // 2552 - non-immutable
    // 417 - immutable
    
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        // set minimum Usd
        // send ETh
        require(
            msg.value.getConversionRate() >= MINIMUN_USD,
            "Didn't send enough!"
        );
        // 18 decimals
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);
        //withdraw the fund

        // transfer
        // msg.sender = address
        // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
        //learn about 3 methods on solidity-by-example
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner!");
        // 713,675 gas
        if (msg.sender != i_owner) { revert NotOwner(); } // 689,373 gas
        _;
    }

    // What if someone sends ETH without calling Fund() function

    receive() external payable {
        fund();
    }


    fallback() external payable {
        fund();
    }
}
