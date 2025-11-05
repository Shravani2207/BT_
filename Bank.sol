// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) public balanceOf;

    // Deposit Ether into your account
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balanceOf[msg.sender] += msg.value;
    }
    // Withdraw Ether
    function withdraw(uint256 amount) public {
        require(amount <= balanceOf[msg.sender], "Insufficient balance");
        balanceOf[msg.sender] -= amount;  // Update state BEFORE transfer
        payable(msg.sender).transfer(amount);
    }

    // Check balance
    function getBalance() public view returns (uint256) {
        return balanceOf[msg.sender];
    }
}
