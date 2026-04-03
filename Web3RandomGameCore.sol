// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Web3RandomGameCore {
    event GamePlayed(address indexed player, uint256 result, bool won);

    function playGame(uint256 guess) external payable returns (bool) {
        require(msg.value == 0.005 ether, "Fee required");
        uint256 result = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 10;
        bool won = result == guess;
        if (won) payable(msg.sender).transfer(msg.value * 2);
        emit GamePlayed(msg.sender, result, won);
        return won;
    }

    function getGameResult() external view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.number))) % 10;
    }
}
