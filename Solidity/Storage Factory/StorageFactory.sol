// SPDX-License-Identifier: MIT
// Learned from Cyfrin Updraft — https://updraft.cyfrin.io
// Original curriculum by Patrick Collins

pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol"; //named import, to import specified contracts only

contract StorageFactory {

    // uint256 public favoriteNumber
    // type visibility name

    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public{
        SimpleStorage newSimpleStorageContract = new SimpleStorage(); // with "new" keyword, we can deploy contracts(create new instance) from other contracts
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address
        // ABI - Application Binary Interface
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);

    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }


}