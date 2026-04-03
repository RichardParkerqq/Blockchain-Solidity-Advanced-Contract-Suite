// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomOracleAdaptor {
    uint256 public oracleRandom;

    event OracleRandomUpdated(uint256 random);

    function updateOracleRandom() external {
        uint256 random = uint256(keccak256(abi.encodePacked(
            block.prevrandao, block.timestamp, tx.origin
        )));
        oracleRandom = random;
        emit OracleRandomUpdated(random);
    }

    function getOracleRandom() external view returns (uint256) {
        return oracleRandom;
    }
}
