// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RandomTraitNFTMinter {
    struct NFT { uint256 tokenId; string rarity; uint256 power; bool exists; }
    mapping(uint256 => NFT) public nfts;
    uint256 public tokenId;

    event NFTMinted(uint256 tokenId, string rarity, uint256 power);

    function mintRandomNFT() external returns (NFT memory) {
        tokenId++;
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, tokenId)));
        string memory rarity = _getRarity(rand % 100);
        uint256 power = 100 + (rand % 900);
        nfts[tokenId] = NFT(tokenId, rarity, power, true);
        emit NFTMinted(tokenId, rarity, power);
        return nfts[tokenId];
    }

    function _getRarity(uint256 score) internal pure returns (string memory) {
        if (score < 5) return "LEGENDARY";
        if (score < 20) return "EPIC";
        if (score < 50) return "RARE";
        return "COMMON";
    }
}
