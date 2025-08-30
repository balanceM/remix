// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TipJar {
    address public owner;

    constructor() { // 合约初始化部署时调用constructor()
        owner = msg.sender; // 部署合约的一方
    }

    // 修饰器
    modifier onlyOwner() { // 验证合约拥有者
        require(msg.sender == owner, "You are not owner.");
        _;
    }

    function tip() public payable { // payable关键字，代表此函数可以接受转账
        require(msg.value > 0, "You should send a tip to use this function");
    }

    function withdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance; // 合约的余额
        require(contractBalance > 0, "There are no tips to withdraw.");

        payable(owner).transfer(contractBalance); // 将余额转账到owner
    }

    function getBalance() public onlyOwner view returns(uint256) {
        return address(this).balance;
    }
}