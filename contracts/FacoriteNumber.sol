// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FavoriteNumber {
    mapping(string => uint256) private nameToFavoriteNumber;

    function createOrUpdateFavoriteNumber(string memory name, uint256 number) public {
        nameToFavoriteNumber[name] = number;
    }

    // view关键字，代表这个方法没有创建修改变量。后续这个方法就不会消耗gas
    // pure关键字，比view更严格，代表这个方法没有创建修改 也没有读取 变量
    function getNumber(string memory name) public view returns (uint256) {
        return nameToFavoriteNumber[name];
    }
}