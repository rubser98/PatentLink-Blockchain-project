// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


interface IERC20{
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    function balanceOf(address account) external view returns(uint);
    function payFilingFee(address sender) external;
}


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

    IERC20 public token;
    uint public patentCounter;
    mapping(uint => Patent) public patents;
    uint filingPrice;
    
    /// @notice  throws an error if the msg.sender is not the owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }
    //evento deposito
    event PatentFiled(uint indexed patentId, address owner);
    //evento cessione
    event PatentAssignment(uint indexed patentId, address from, address to);


    constructor(address tokenAddress) ERC721("PatentNFT","PTNFT"){
        token = IERC20(tokenAddress);
        patentCounter = 0;
    }

    function filePatent(string memory _uri) public payable{
        require(token.payFilingFee(msg.sender),"Not enough PatentToken to deposit your patent!");
        patents[patentCounter] = Patent({ 
            onSale: false, 
            price:0,
            timestamp: block.timestamp,
            deadline: block.timestamp + (20 * 365 days)});
        _safeMint(msg.sender, patentCounter);
        _setTokenURI(patentCounter, _uri);
        emit PatentFiled(patentCounter, msg.sender);
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


    function getPatentprice(uint patentId) public returns(int){
        return patents[patentId].price;
    }


    function getPatentsURIbyOwner(address _owner) public returns(Patent[]){
        Patent[] memory patentsByOwner; 
        for(i=0; i < patentCounter; i++){
            if (patents[i].owner == _owner){
                patentsByOwner.push(patents[i]);
            }
        }
        return patentsByOwner;
    }

    function getPatents() public returns (mapping(uint => string)){
       return _tokenURIs;
    }
}