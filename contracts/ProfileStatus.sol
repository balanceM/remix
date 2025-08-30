// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProfileStatus {
    struct Status {
        string name;
        string message;
    }

    mapping(address => Status) private userStatus;

    function createOrUpdateStatus(string memory _name, string memory _message) public {
        userStatus[msg.sender].name = _name;
        userStatus[msg.sender].message = _message;
    }

    function getStatus() public view returns (string memory, string memory) {
        return (userStatus[msg.sender].name, userStatus[msg.sender].message);
    }
}