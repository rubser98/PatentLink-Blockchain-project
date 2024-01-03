// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/// @title Patent Token contract
/// @author Carolina Proietti, Edoardo Giuggioloni, Paolo Marchignoli, Ruben Seror 
/// @notice You can use this contract to buy and sell PTNT, see accounts balances
contract PatentToken is ERC20{

    address public owner;
    uint public filingFee;
    
    event Buy(address indexed buyer, uint value);
    event Sell(address indexed seller, uint value);

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

    function buyToken(uint amount) public{

    }

    function sellToken(uint amount) public{

    }

    function payFilingFee(address _sender) public returns(bool){
        return _transferFrom(owner, _sender, filingFee);
    }

    function setFilingFee(uint amount) public{
        filingFee = amount * (10 ** decimals());
    }


}