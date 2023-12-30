// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PatentNFT is ERC721{

    struct Patent {
        string title;
        uint timestamp;
        uint expired_date;
        bool on_sale;
        uint price;
        string description;
        address creator;
    }
    
    uint public patentCounter;
    mapping(uint => Patent) public patents;



    constructor() ERC721("PatentNFT","PTNFT"){
        patentCounter = 0;
    }

    function mintPatentNFT(string) public returns(uint){
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        return s_tokenCounter;
    }
    
    function getTokenCount() returns(uint){
        return s_tokenCounter;
    }
}