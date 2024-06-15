// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract SimpleStorage {
    // boolean, uint, int, address, bytes, string
    bool hasFavoriteNumber = true;
    uint favoriteNubmer;      // default uint256 8, 16 default number 0 
    //public(getter function) private internal(default) external

    mapping(string => uint) public nameToFavoriteNumber;
    
    struct People {
        uint favoriteNubmer;
        string name;
    }

    People[] public people;

    function store(uint _favoriteNumber) public{ 
        favoriteNubmer = _favoriteNumber;
    }

    // view - no gas - no change - unless inside function cost gas
    function retrieve() public view returns(uint){
        return favoriteNubmer;
    }

    //call data, memory, storage
    function addPerson(string memory _name, uint _favoriteNumber) public {
        people.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}
