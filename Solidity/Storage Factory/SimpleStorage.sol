// SPDX-License-Identifier: MIT
// Learned from Cyfrin Updraft — https://updraft.cyfrin.io
// Original curriculum by Patrick Collins

pragma solidity ^0.8.18; // stating our version

contract SimpleStorage {
    
    uint256 myFavoriteNumber;  // default value is 0

    // uint256[] listOfFavoriteNumbers; 
    
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // dynamic/static array
    Person[] public listOfPeople;  //[] 

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber; 
    }
    
    // view, pure
    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    // calldata(temporary, unmodified)
    // memory(temporary, modified) 
    // storage(permanent, modified)
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
