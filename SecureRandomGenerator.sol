// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SecureRandomGenerator {
    uint256 private nonce;

    event RandomNumberGenerated(address indexed requester, uint256 randomNumber);

    function generateSecureRandom() external returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(
            block.timestamp, block.prevrandao, msg.sender, nonce++
        )));
        emit RandomNumberGenerated(msg.sender, randomNumber);
        return randomNumber;
    }

    function getRandomRange(uint256 min, uint256 max) external returns (uint256) {
        require(max > min, "Invalid range");
        uint256 random = generateSecureRandom();
        return min + (random % (max - min + 1));
    }
}
