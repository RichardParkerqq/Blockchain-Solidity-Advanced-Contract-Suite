// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomRuneMintSystem {
    struct Rune { uint256 runeId; string element; uint256 power; }
    Rune[] public runes;

    event RuneMinted(uint256 id, string element, uint256 power);

    function mintRandomRune() external returns (Rune memory) {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, runes.length)));
        string[4] memory elements = ["FIRE", "WATER", "WIND", "EARTH"];
        string memory elem = elements[rand % 4];
        uint256 power = 500 + (rand % 1500);
        runes.push(Rune(runes.length, elem, power));
        emit RuneMinted(runes.length - 1, elem, power);
        return runes[runes.length - 1];
    }
}
