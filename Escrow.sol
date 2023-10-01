// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        //Only if the arbiter approves that the transfer has happened or the task has been completed it will call this approve function
        if(msg.sender != arbiter){
            revert();
        }
        //Once this approve function is called in by the arbiter then the function will transfered to the beneficiary
        uint balance = address(this).balance;
        (bool s,) = beneficiary.call{value:balance}("");
        require(s);
        emit Approved(balance);
    }
}