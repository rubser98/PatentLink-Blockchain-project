// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


/// @title PatentNFT contract
/// @author Carolina Proietti, Edoardo Giuggioloni, Paolo Marchignoli, Ruben Seror 
/// @notice You can use this contract to file patent, buy and sell associated NFTs
contract PatentNFT is ERC721{

    // Struttura dei brevetti
    struct Patent {
        string name; // Nome del brevetto
        string uri; // URI che indica l'oggetto off-chain 
        address owner; // Indirizzo del proprietario del brevetto
        bool onSale; //brevetto in vendita (s/n)
        uint price; //prezzo brevetto (0 se non è in vendita)
        uint timestamp;//data deposito brevetto
        uint deadline;//scadenza brevetto
    }
    
    uint public patentCounter;
    mapping(uint => Patent) public patents;
    uint filingPrice;
    
    /// @notice  throws an error if the msg.sender is not the owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    event PatentFiled(uint indexed patentId, string name, address owner);


    constructor() ERC721("PatentNFT","PTNFT"){
        patentCounter = 0;
    }

    function filePatent(string memory _name, string memory _uri) public payable{
        require(msg.value > depositPatent,"Not enough PatentToken to deposit your patent!");
        patents[patentCounter] = Patent({
            name: _name, 
            uri: _uri,
            owner: msg.sender, 
            onSale: false, 
            price:0,
            timestamp: block.timestamp,
            deadline: block.timestamp + (20 * 365 days)});
        _safeMint(msg.sender, patentCounter);
        emit PatentFiled(patentCounter, _name, msg.sender);
        patentCounter++;
    }

    function setPatentOnSale(uint patentId, uint price) public {
        require(patents[patentId].owner == msg.sender,"You are not the owner of the patent");
        patents[patentId].price = price;
        patents[patentId].onSale = true;
        
    }
    
    function getTokenCount() returns(uint){
        return patentCounter;
    }

    function setFilingPrice(uint price) public onlyOwner {
        filingPrice = price;
    }
}