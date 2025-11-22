// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can call this function");
        _;
    }

    function test() public pure virtual returns (uint256) {
        return 1;
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }
}

// 子合约
contract MyContract is Ownable {
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;        
    }

    function test() public pure override returns (uint256) {
        return 2;
    }
}