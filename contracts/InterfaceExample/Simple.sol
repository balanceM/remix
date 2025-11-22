// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address addr) external view returns (uint256);
}

contract ERC20 is IERC20 {
    function transfer(address to, uint256 amount) external pure returns (bool) {
        return false;
    }
    
    function balanceOf(address addr) external pure returns (uint256) {
        return 1;
    }
}