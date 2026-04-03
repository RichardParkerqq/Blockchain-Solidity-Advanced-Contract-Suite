// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomAirdropDistributor {
    address public owner;
    address[] public eligibleUsers;
    uint256 public airdropAmount;

    constructor() { owner = msg.sender; }

    function setEligibleUsers(address[] calldata users) external onlyOwner {
        eligibleUsers = users;
    }

    function setAirdropAmount(uint256 amount) external onlyOwner {
        airdropAmount = amount;
    }

    function randomAirdrop() external onlyOwner {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, block.number)));
        address winner = eligibleUsers[rand % eligibleUsers.length];
        payable(winner).transfer(airdropAmount);
    }

    modifier onlyOwner() { require(msg.sender == owner); _; }
}
