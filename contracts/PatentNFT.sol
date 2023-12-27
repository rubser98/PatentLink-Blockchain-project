// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PatentNFT{

    uint256 private s_tokenCounter;

    constructor() ERC721("Patent","PTNFT"){
        s_tokenCounter = 0;
    }

    function mintNFT() public returns(uint){
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        return s_tokenCounter;
    }
    
    function getTokenCount() returns(uint){
        return s_tokenCounter;
    }
}