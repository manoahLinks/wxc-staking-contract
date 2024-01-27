// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract Erc20 {
    // state variables
    string public tokenName;
    string public symbol;
    uint public decimal;
    uint public totalSupply;
    address public owner;
    

    // mappings
    mapping(address => uint) public balanceOf;

    // constructor
    constructor() {
        tokenName = "web3cohortx";
        symbol = "WCX";
        decimal = 18;
        owner = msg.sender;
        mintToken(30000000);
        balanceOf[msg.sender] += totalSupply;
    }

    //events
    event transferEvent(
        address indexed recipient,
        address indexed sender,
        uint amount
    );

    // approval event
    event approval(
        address indexed owner,
        address indexed spender,
        uint amount
    );

    //allowance mapping

    

    /// ADD CHECKS TO OWNER
    modifier onlyOwner {
        require(msg.sender==owner,"Function can only be triggered by owner");
        _;
    }
    // allowance mapping of mappings
    mapping (address => mapping(address=> uint)) public allowance;



    /// MINT TOKEN

    function mintToken(uint _amount) onlyOwner public {
        totalSupply +=_amount;
    }
     //burn token
    function burnToken(uint _amount)onlyOwner public{
        totalSupply -=_amount;
    }

    // functions
    // transfer functions
    function transfer(address _to, uint _amount) public {
        //check if the balance is available
        require(
            balanceOf[msg.sender] >= _amount,
            "you no get money commot from here!!"
        );
        //substract amount from sender balance
        balanceOf[msg.sender] -= _amount;
        //add amount to recipent
        balanceOf[_to] += _amount; 

        //emit transfer event
        emit transferEvent(_to, msg.sender, _amount);
    }
    // approve function
    function approve (address _spender, uint _amount) public {
        // owner permits spender to spend amount
        allowance[msg.sender] [_spender] = _amount;
        // emit approval event
        emit approval(msg.sender, _spender, _amount);
    } 
    // transferFrom function: it can only be called from outside the contract
    function transferFrom (address _sender, address _recepient, uint _amount) external{
        // subtract amount from the spender and give allowance to recepient
        allowance[_sender][_recepient]  -= _amount;
        // subtract amount from the balance of the sender
        balanceOf[_sender] -= _amount;

        //adding the amount to the balance of the recepient
        balanceOf[_recepient] += _amount;
        
        //emitting the transfer event
        emit transferEvent(_recepient, _sender, _amount);
    }
    
}
