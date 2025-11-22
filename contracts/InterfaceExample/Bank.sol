// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

interface IBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
    function getBalance() external view returns (uint256);
}

// 银行合约
contract Bank is IBank {
    mapping(address => uint256) public balances;

    function deposit() external payable override {
        require(msg.value > 0, "Deposit amount must be over 0");
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint256 amount) external override {
        require(amount <= balances[msg.sender], "Insufficient balance");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    function getBalance() external view override returns (uint256)  {
        return balances[msg.sender];
    }
}

// 使用银行接口的合约
contract BankUser {
    function depositToBank(address bankAddress) external payable {
        IBank bank = IBank(bankAddress);
        bank.deposit{value: msg.value}();
    }

    // 接收银行合约转账的ETH
    receive() external payable {}
    // 可选：如果需要处理额外数据，添加 fallback 函数
    // fallback() external payable {}

    function withdrawFromBank(address bankAddress, uint256 amount) external {
        IBank bank = IBank(bankAddress);
        bank.withdraw(amount);
    }
    function getBankBalance(address bankAddress) external view returns (uint256) {
        IBank bank = IBank(bankAddress);
        return bank.getBalance();
    }
}