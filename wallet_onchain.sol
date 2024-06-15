// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract WALLET {
    address payable public specificAddress;

    constructor() {
        specificAddress = payable(INSERT YOUR WALLET ADDRESS HERE);
    }

    receive() external payable {
    }

    function withdraw() external {
        require(msg.sender == specificAddress, "Only specific address can withdraw");
        specificAddress.transfer(address(this).balance);
    }
}