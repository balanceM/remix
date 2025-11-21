// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Caller {
    function getTxInfo() public view returns (address) {
        return tx.origin;
    }

    function getMsgInfo() public view returns (address) {
        return msg.sender;
    }
}

contract Callee {
    Caller caller;
    constructor() {
        caller = new Caller();
    }

    function getTxInfo() public view returns (address) {
        return caller.getTxInfo();
    }

    function getMsgInfo() public payable returns (address, address, uint) {
        return (caller.getMsgInfo(), msg.sender, msg.value);
    }

    function getContractAddr() public view returns (address) {
        return address(this);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}