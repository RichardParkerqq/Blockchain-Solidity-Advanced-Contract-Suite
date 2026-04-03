// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomMembershipNFT {
    enum Level { BRONZE, SILVER, GOLD, DIAMOND }
    mapping(address => Level) public membership;

    event MembershipMinted(address indexed user, Level level);

    function mintMembership() external {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
        Level level;
        if (rand < 10) level = Level.DIAMOND;
        else if (rand < 30) level = Level.GOLD;
        else if (rand < 60) level = Level.SILVER;
        else level = Level.BRONZE;
        membership[msg.sender] = level;
        emit MembershipMinted(msg.sender, level);
    }
}
