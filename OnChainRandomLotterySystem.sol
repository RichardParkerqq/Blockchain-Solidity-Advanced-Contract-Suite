// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OnChainRandomLotterySystem {
    address public owner;
    address[] public participants;
    uint256 public lotteryId;
    address public winner;

    constructor() { owner = msg.sender; }

    function joinLottery() external payable {
        require(msg.value == 0.01 ether, "Pay fee");
        participants.push(msg.sender);
    }

    function drawWinner() external onlyOwner {
        require(participants.length > 0, "No participants");
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, lotteryId++)));
        winner = participants[rand % participants.length];
        payable(winner).transfer(address(this).balance);
        participants = new address[](0);
    }

    modifier onlyOwner() { require(msg.sender == owner, "Not owner"); _; }
}
