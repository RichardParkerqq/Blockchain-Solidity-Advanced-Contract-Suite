// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NFTBlindBoxRandomSystem {
    struct BlindBox { uint256 boxId; uint256[] nftIds; bool opened; }
    mapping(uint256 => BlindBox) public boxes;
    uint256 public boxCount;

    event BoxCreated(uint256 boxId, uint256[] nftIds);
    event BoxOpened(uint256 boxId, uint256 rewardNftId);

    function createBlindBox(uint256[] calldata nftIds) external {
        boxCount++;
        boxes[boxCount] = BlindBox(boxCount, nftIds, false);
        emit BoxCreated(boxCount, nftIds);
    }

    function openBlindBox(uint256 boxId) external returns (uint256) {
        BlindBox storage box = boxes[boxId];
        require(!box.opened, "Already opened");
        box.opened = true;
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, boxId))) % box.nftIds.length;
        uint256 reward = box.nftIds[rand];
        emit BoxOpened(boxId, reward);
        return reward;
    }
}
