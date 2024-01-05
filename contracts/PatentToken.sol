// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/// @title Patent Token contract
/// @author Carolina Proietti, Edoardo Giuggioloni, Paolo Marchignoli, Ruben Seror 
/// @notice You can use this contract to buy and sell PTNT, see accounts balances
contract PatentToken is ERC20{

    address public owner;
    uint public filingFee;
    
    event BuyPTNT(address indexed buyer, uint value);
    event SellPTNT(address indexed seller, uint value);

    /// @notice  throws an error if the msg.sender is not the owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    constructor(uint _filingFee)
        ERC20("PatentToken", "PTNT") {
            owner = msg.sender;
            filingFee = _filingFee;
            _mint(owner, 100000 * (10 ** decimals()));
        }
    ///@notice It allows sender to purchase PTNT
    ///@param amount amount of PTNT to purchase
    function buyToken(uint amount) public payable{
        uint ptnt = amount * (10 ** decimals()); 
        require(balanceOf(owner) >= ptnt, 'Not enough PTNT in the economy');
        require(msg.value > ptnt,'Not enough ETH to buy PTNT');
        emit BuyPTNT(msg.sender, ptnt);
        _transfer(owner,msg.sender,ptnt);
    }

    ///@notice It allows sender to convert PTNT into ETH
    ///@param amount amount of PTNT to sell  
    function sellToken(uint amount) public{
        require(amount > 0, 'No amount of PTNT are specified');
        uint ptnt = amount * (10 ** decimals());
        require(balanceOf(msg.sender) > ptnt, 'You do not have that amount of PTNT');
        emit SellPTNT(msg.sender,ptnt);
        payable(msg.sender).transfer(ptnt);
        _transfer(msg.sender, owner, ptnt);

    }

    ///@notice Sender pay filingFee to file patent
    ///@param _sender address of account which pay the fee
    function payFilingFee(address _sender) external returns(bool){
        require(balanceOf(_sender)> filingFee,'Not enough PTNT to pay filing fee');
        _transfer(_sender, owner, filingFee);
        return true;
    }

    ///@notice set the price of filing fee
    ///@param amount new price of filing fee
    function setFilingFee(uint amount) public onlyOwner{
        filingFee = amount;
    }

    ///@notice emit PTNT 
    ///@param amount amount of PTNT minted
    function mint(uint amount) public onlyOwner{
        _mint(owner, amount * (10 * decimals()));
    }

}