// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrossChainRandomCaller {
    uint256 public lastCrossChainRandom;

    event CrossChainRandomReceived(uint256 random);

    function requestCrossChainRandom() external {
        uint256 random = uint256(keccak256(abi.encodePacked(
            block.chainid, block.timestamp, block.prevrandao, msg.sender
        )));
        lastCrossChainRandom = random;
        emit CrossChainRandomReceived(random);
    }

    function getCrossChainRandomInRange(uint256 min, uint256 max) external view returns (uint256) {
        return min + (lastCrossChainRandom % (max - min + 1));
    }
}
