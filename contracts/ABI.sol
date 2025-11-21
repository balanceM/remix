// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// Application Binary Interface 应用二进制接口
contract ABI {
    // 编码
    function encodeData(string memory text, uint256 number) public pure returns (bytes memory, bytes memory) {
        return (abi.encode(text, number), abi.encodePacked(text, number));
    }
    // 解码
    function decodeData(bytes memory encodedData) public pure returns (string memory text, uint256 number) {
        (text, number) = abi.decode(encodedData, (string, uint256));
    }
    // 当前函数签名
    function getSelector() public pure returns (bytes4) {
        return msg.sig;
    }
    // 计算函数选择器
    function computeSelector(string memory func) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(func)));
    }

    function transfer(address addr, uint256 amount) public pure returns (bytes memory) {
        return msg.data;
    }
    // 调用函数 生成msg.data
    function encodeFunctionCall() public pure returns (bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, 100);
    }

    // 哈希运算
    function hashFunctions(string memory input) public pure returns(bytes32, bytes32, bytes32) {
        bytes memory data = abi.encodePacked(input);
        return (
            keccak256(data),
            sha256(data),
            ripemd160(data)
        );
    }

    // 数学运算
    function modularMath(uint256 x, uint256 y, uint256 m) public pure returns (uint256, uint256) {
        return (
            addmod(x, y, m),
            mulmod(x, y, m)
        );
    }

    // 椭圆曲线恢复公钥
    function recoverAddress(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return ecrecover(hash, v, r, s);
    }
}