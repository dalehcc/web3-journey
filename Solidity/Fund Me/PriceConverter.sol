// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// import directly from Github
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


// move math calc of FundMe contract into a library
library PriceConverter {

    function getPrice() internal view returns(uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306 (sepolia, ETH/USD) - acquired from Chainlink/Devhubs/Feed Addresses
        // ABI - a set of rules for encode/decode, translation layer between EVM bytecodes and human readable codes
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( ,int256 price, , ,) = priceFeed.latestRoundData(); // return ETH price in terms of USD, 8 decimals
        return uint256(price * 1e10); // type change for price: int256 > uint256
    }
    
    //math in solidity, no decimals
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // since both ethAmount and ethPrice are of 18 zeros
        return ethAmountInUsd;
    }

    function getVersion() internal view returns(uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}