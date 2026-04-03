// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomTaskRewardSystem {
    struct Task { string taskName; uint256 reward; bool completed; }
    mapping(address => Task) public userTasks;

    function generateRandomTask() external returns (Task memory) {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 3;
        string memory name;
        uint256 reward;
        if (rand == 0) { name = "STAKE"; reward = 50; }
        else if (rand == 1) { name = "INVITE"; reward = 100; }
        else { name = "VOTE"; reward = 75; }
        userTasks[msg.sender] = Task(name, reward, false);
        return userTasks[msg.sender];
    }

    function completeTask() external {
        userTasks[msg.sender].completed = true;
    }
}
