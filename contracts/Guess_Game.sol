//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Guess_Game {
    // Declares a state variable `random_number` of type `uint4` which is just an unsigned 4 bit integer.
    // State variables are variables whose values are permanently stored in contract storage.
    uint random_number;
    bool game_completion;

    // This is an Struct that defines value for the user that interacting with the smart contract
    struct player {
        address player_address;
        uint trials;
    }

    // We instantiated a array of player structs that keeps tracks of every user that has even used the dapp
    player[] public players;

    // Similar to many class-based object-oriented languages, a constructor is a special function that is only executed upon contract creation.
    // Constructors are used to initialize the contract's data. Learn more:https://solidity.readthedocs.io/en/v0.5.10/contracts.html#constructors
    constructor() {

        // Depending on the timestamp of the current block, the keccak function will generate a random number and we're keeping it between 1 and 100
        random_number = uint(keccak256(abi.encodePacked(block.timestamp))) % 100;
        
        // When the contract is deployed, we initialize this variable as false since no one has won yet
        game_completion = false;
    }

    // Updates the players array with the user details when he tries to
    // msg.sender is a way of retrieving the users address and we're assigning 10 trials to the user 
    function Add_Player() public {
        player memory new_player = player(msg.sender, 10);
        players.push(new_player);
    }

    function Guess(uint) public {
        uint trials_remaining;
        bool registered;

        if (players.length == 0) {
            Add_Player();
        }

        else {
            for(uint i = 0; i < players.length; i++) {
                if (players[i].player_address == msg.sender) {
                    trials_remaining = players[i].trials;
                    registered = true;
                    break;
                }
            }

            if (registered = false) {
                Add_Player();
            }
        }
        
        require(game_completion, "The game has already been won");

        for (uint i = 0; i < trials_remaining; trials_remaining--) {

        }





    }
}