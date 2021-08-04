// SPDX-License-Identifier: MIT

//TODO: Resources
//https://remix.ethereum.org
//https://mumbai.polygonscan.com/address/0xf7218d3b5719dbf8d44091b829b81438a8f5f576

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TopPostAwardToken is ERC721, ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("TopPostAward", "TPA") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
    }

    function awardTopPost(address to, string memory topPostURI) public onlyRole(MINTER_ROLE) returns(uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        super._safeMint(to, tokenId);
        super._setTokenURI(tokenId, topPostURI);
        _tokenIdCounter.increment();
        return tokenId;
    }

    function lastTokenId() public view returns(uint256) {
        return _tokenIdCounter.current() - 1;
    }


    function _burn(uint256 tokenId) internal onlyRole(MINTER_ROLE) override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage)
    returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, AccessControl)
    returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
