// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomStakeMiningBoost {
    mapping(address => uint256) public stakeAmount;
    mapping(address => uint256) public boostRate;

    function stakeETH() external payable {
        stakeAmount[msg.sender] += msg.value;
        uint256 randBoost = 10 + (uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 40);
        boostRate[msg.sender] = randBoost;
    }

    function calculateMiningReward(address user) external view returns (uint256) {
        return stakeAmount[user] * boostRate[user] / 100;
    }
}
