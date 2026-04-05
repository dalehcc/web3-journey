// SPDX-License-Identifier: MIT
// Learned from Cyfrin Updraft — https://updraft.cyfrin.io
// Original curriculum by Patrick Collins

pragma solidity ^0.8.18;

//inheritance, child contract
contract AddFiveStorage is SimpleStorage{
    // +5 to favorite number
    // overrides
    // "virtual" keyword added to parant contract to make it overridable
    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }

}


