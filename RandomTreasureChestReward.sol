// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomTreasureChestReward {
    event ChestOpened(address indexed user, string rewardType, uint256 amount);

    function openTreasureChest() external returns (string memory, uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
        string memory rewardType;
        uint256 amount;
        if (rand < 10) { rewardType = "NFT"; amount = 1; }
        else if (rand < 40) { rewardType = "TOKEN"; amount = 1000; }
        else { rewardType = "ITEM"; amount = 5; }
        emit ChestOpened(msg.sender, rewardType, amount);
        return (rewardType, amount);
    }
}
