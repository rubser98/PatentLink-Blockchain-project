// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


interface IERC20{
    function transfer(address from, address to, uint amount) external returns (bool);
    function balanceOf(address account) external view returns(uint);
    function payFilingFee(address sender) external returns(bool);
}


/// @title PatentNFT contract
/// @author Carolina Proietti, Edoardo Giuggioloni, Paolo Marchignoli, Ruben Seror 
/// @notice You can use this contract to file patent, buy and sell associated NFTs
contract PatentNFT is ERC721URIStorage{

    // Struttura dei brevetti
    struct Patent {
        bool forSale; //brevetto in vendita (s/n)
        uint price; //prezzo brevetto (0 se non è in vendita)
        uint timestamp;//data deposito brevetto
        uint deadline;//scadenza brevetto
    }

    IERC20 public token;
    uint private patentCounter;
    mapping(uint => Patent) public patents;
    uint filingPrice;
    

    //evento deposito
    event PatentFiled(uint indexed patentId, address owner);
    //evento cessione
    event PatentAssignment(uint indexed patentId, address from, address to);


    constructor(address tokenAddress) ERC721("PatentNFT","PTNFT"){
        token = IERC20(tokenAddress);
        patentCounter = 0;
    }

    ///@notice method that allow user to file their patents
    ///@param _uri URI of the filed Patent in IPFS
    function filePatent(string memory _uri) public{
        require(token.payFilingFee(msg.sender),'Filing fee payment failed');
        patents[patentCounter] = Patent({ 
            forSale: false, 
            price:0,
            timestamp: block.timestamp,
            deadline: block.timestamp + (20 * 365 days)});
        _safeMint(msg.sender, patentCounter);
        _setTokenURI(patentCounter, _uri);
        emit PatentFiled(patentCounter, msg.sender);
        patentCounter++;
    }
    ///@notice user can put the patent up for sale
    ///@param patentId nft id of the patent
    function setPatentForSale(uint patentId, uint price) public {
        require(_ownerOf(patentId) == msg.sender,'You are not the owner of the patent');
        require(block.timestamp < patents[patentId].deadline,'The patent has expired');
        require(patents[patentId].forSale, 'Patent already up for sale');
        patents[patentId].price = price;
        patents[patentId].forSale = true;
    }

    ///@notice user can remove the patent from sale
    ///@param patentId nft id of the patent
    function setPatentNotForSale(uint patentId) public {
        require(_ownerOf(patentId) == msg.sender,'You are not the owner of the patent');
        require(block.timestamp < patents[patentId].deadline,'The patent has expired');
        require(patents[patentId].forSale == false, 'Patent already not up for sale');
        patents[patentId].price = 0;
        patents[patentId].forSale = false;    
    }

    function buyPatent(uint patentId) public {
        require(_ownerOf(patentId) != address(0),'The patent does not exist');
        require(patents[patentId].forSale,'The patent is not in sale');
        require(block.timestamp < patents[patentId].deadline,'The patent has expired');
        require(token.transfer(msg.sender,_ownerOf(patentId), patents[patentId].price),'You have not enough PTNT to buy the patent');
        emit PatentAssignment(patentId, _ownerOf(patentId), msg.sender);
        _transfer(_ownerOf(patentId), msg.sender, patentId);
    }
    
    ///@notice return number of filed patents
    function getTokenCount() public view returns(uint){
        return patentCounter;
    }

    ///@notice return the price in PTNT of a specific patent
    ///@param patentId id of the nft associated to the patent
    function getPatentprice(uint patentId) public view returns(uint){
        return patents[patentId].price;
    }


}