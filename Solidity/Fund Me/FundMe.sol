// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// import directly from Github
import {PriceConverter} from "./PriceConverter.sol"; //import customized library


error NotOwner();

contract FundMe {
    
    using PriceConverter for uint256;

    uint public constant MININUM_USD = 5e18;  //constant - known at compile time 

    address[] public funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;  //the immustable var is known and locked at deployment, and can't be reassigned
    
    constructor() {               //immediately called whenever contract is deployed
        i_owner = msg.sender;
    }

    // allow user to send $
    //balance has mininum $ to send
    function fund() public payable {
        
        require((msg.value.getConversionRate()) > MININUM_USD, "Didn't send enough ETH"); //msg.value - # of wei sent with a msg/tx
        funders.push(msg.sender); //msg.sender - The immediate caller of the current function
        addressToAmountFunded[msg.sender] += msg.value; 
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Must be owner, but you are not!!") - replaced by modifier below
        
        // for loop, go thru each element in an array
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset array to empty
        funders = new address[](0);
        
        // withdraw the funds

        //1. transfer - automatically reverts if fail
        /// payable(msg.sender).transfer(address(this).balance); // payable() makes msg.sender from address > payable address
        
        //2. send - return bool, no revert
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        
        //3. call 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call Failed");
    }

    modifier onlyOwner() {
        require(msg.sender == i_owner, "Sender is not owner!");
        // if(msg.sender != i_owner) {revert NotOwner();}   //custom error log, more gas-efficient
        _;   //execute require before func ops
        

    }

    receive() external payable {
        fund();  // route to fund func
    }

    fallback() external payable {
        fund();  // route to fund func
    }

}