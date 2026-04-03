// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomDividendShareSystem {
    address[] public holders;
    uint256 public totalDividend;

    function depositDividend() external payable {
        totalDividend += msg.value;
    }

    function distributeRandomDividend() external {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, block.number)));
        address winner = holders[rand % holders.length];
        payable(winner).transfer(totalDividend);
        totalDividend = 0;
    }

    function joinHolder() external { holders.push(msg.sender); }
}
