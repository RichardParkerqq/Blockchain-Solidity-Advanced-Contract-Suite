// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DeFiRandomYieldFarming {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public yieldRate;

    event Staked(address indexed user, uint256 amount);
    event YieldClaimed(address indexed user, uint256 reward);

    function stake() external payable {
        stakes[msg.sender] += msg.value;
        uint256 rate = 5 + (uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 15);
        yieldRate[msg.sender] = rate;
        emit Staked(msg.sender, msg.value);
    }

    function claimYield() external returns (uint256) {
        uint256 reward = stakes[msg.sender] * yieldRate[msg.sender] / 100;
        payable(msg.sender).transfer(reward);
        emit YieldClaimed(msg.sender, reward);
        return reward;
    }
}
