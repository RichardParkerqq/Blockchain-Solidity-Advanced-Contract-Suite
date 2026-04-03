// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomAssetSynthesisCore {
    event Synthesized(address indexed user, uint256 resultId, uint256 rarity);

    function synthesizeAssets(uint256[] calldata materialIds) external returns (uint256, uint256) {
        uint256 hash = uint256(keccak256(abi.encodePacked(materialIds, block.timestamp, msg.sender)));
        uint256 resultId = hash % 10000;
        uint256 rarity = 1 + (hash % 5);
        emit Synthesized(msg.sender, resultId, rarity);
        return (resultId, rarity);
    }

    function getSynthesisRate() external view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.number))) % 100;
    }
}
