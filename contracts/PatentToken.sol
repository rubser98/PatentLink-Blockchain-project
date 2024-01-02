// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Patent Token contract
/// @author Carolina Proietti, Edoardo Giuggioloni, Paolo Marchignoli, Ruben Seror 
/// @notice You can use this contract to buy and sell PTNT, see accounts balances
contract PatentToken is ERC20,ERC20Capped, ERC20Burnable{

    address public owner;
    uint public blockReward;

    /// @notice  throws an error if the msg.sender is not the owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    constructor(uint cap, uint reward)
        ERC20("PatentToken", "PTNT") ERC20Capped(cap * (10 ** decimals())){
            owner = msg.sender;
            _mint(owner, 70000000 * (10 ** decimals()));
            blockReward = reward * (10 ** decimals());
        }

    function setBlockReward(uint newReward) public onlyOwner {
        blockReward = newReward * (10 ** decimals());
    }

    function _mintMinerReward() internal{
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint value) internal virtual override{
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from,to,value);   
    }

    function destroy() public onlyOwner(){
        selfdestruct(owner);
    }


}