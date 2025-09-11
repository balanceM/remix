// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 private data;

    event DataStored(address indexed sender, uint256 data);

    function storeData(uint256 _data) public {
        data = _data;
        emit DataStored(msg.sender, _data);
    }

    function getData() public view returns (uint256) {
        return data;
    }
}