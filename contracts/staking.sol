// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IERC20, Erc20} from './erc20.sol';

contract Staking {

    struct Staker {
        uint stakeCount;
        uint amount;
        uint stakeDuration;
        uint reward;
    }

     IERC20  wcxToken;

    constructor () {
        wcxToken = new Erc20();
    }

    mapping (address => Staker) public stakers;
    mapping (address => uint) public balanceOf;

    function calculateReward(uint _amount, uint _stakedTime) private view returns(uint) {
        require(_stakedTime < block.timestamp, "Go home");
        uint totalSec = block.timestamp - _stakedTime;
        uint secToDay = totalSec / 86400;
        uint reward = addReward(_amount) * secToDay;
        return reward;
    }    

    function addReward(uint _amount) internal pure returns(uint) {
       
     return _amount * 1/5000;
    }

    function stake(uint _amount) public returns(bool) {
        require(wcxToken.getUserBalance(msg.sender) >= _amount, "wahala");
        wcxToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        return true;
    }



}