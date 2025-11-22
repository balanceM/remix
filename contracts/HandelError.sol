// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract HandleError {
    function requireError(bool condition) public pure returns (uint256) {
        require(condition, "input is not 'true'");
        return 1;
    }

    function assertError(bool condition) public pure returns (uint256) {
        assert(condition); // false时，会panic
        return 1;
    }

    // 自定义错误类型
    error Unauthorized(); // 简单错误，不带参数
    error InsufficientBalance(uint256 available, uint256 required); // 带参数
    error TransferFailed(address from, address to, uint256 amount, string reason); // 带复杂参数
    function revertError(bool condition) public pure returns (uint256) {
        if (!condition) {
            // revert("input is not 'true'");
            // revert Unauthorized();
            // revert InsufficiantBalance(100, 105);
            // revert TransferFailed(msg.sender, address(this), 100, "105");
            revert("TransferFailed");
        }
        return 1;
    }
}

contract catchTryContract {
    HandleError public he;

    constructor() {
        he = new HandleError();
    }

    function trycatch(bool condition) public view returns (string memory) {
        try he.revertError(condition) returns (uint256) {
            // 调用成功时执行的代码
            // 可以使用返回值result
            return "success";
        } catch Error(string memory reason) {
            // 当revert(reasonString) 或 require(false, reasonString) 被调用时
            // 可以访问 reason
            return string.concat("reason::: ", reason);
        } catch Panic(uint) {
            // 当发生panic错误时（如 除以0、数组越界等）
            // errorCode表示错误类型
            return "panic";
        } catch (bytes memory lowLevelData) {
            // 当错误不符合上述任何类型时
            // 包含低级错误数据
            return string.concat("lowLevelData::: ", string(lowLevelData));
        }
    }
}

contract Owner {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 自定义修饰符
    modifier onlyOwner {
        require(msg.sender == owner, "you are not owner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}