//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// Check out the official document to learn more about every concept here: https://docs.soliditylang.org/en/v0.8.13/index.html
contract Guess_Game {

    //  Declared state variables whose values are permanently stored in contract storage.
    uint random_number;
    bool game_completion;
    address winner;

    // This is an Struct that defines value for the user that interacting with the smart contract
    struct player {
        uint guess;
        uint trials;
        bool registered;
    }

    // Created a mapping of an address to the player Struct
    mapping (address => player) player_structs;

    // Created a dynamic array of player addresses 
    address[] internal players_addresses;


    // Defining the Contructor which is a block of code that runs the instant the contract is deployed
    constructor() {

        // Depending on the timestamp of the current block, the keccak function will generate a random number and we're keeping it between 1 and 100
        random_number = uint(keccak256(abi.encodePacked(block.timestamp))) % 100;
        
        // When the contract is deployed, we initialize this variable as false since no one has won yet
        game_completion = false;
    }

    // Generates a new struct with msg.sender which just the user's wallet address and appends it to the array 
    function set_Player() internal {
        player_structs[msg.sender].guess = 0;
        player_structs[msg.sender].trials = 5;
        player_structs[msg.sender].registered = true;

        players_addresses.push(msg.sender);
    }

    // A function for verifying if a user has been tried to guess before and is registered
    function get_Player(address _player) internal view returns(bool) {
        return player_structs[_player].registered;
    }

    // This function is visible to the user, it reads the user's input and calls the game function
    function Guess(uint _Guess) public {
        if (game_completion) {
            console.log("Game has been completed and the winning address is ", winner);
        }

        // Checks to see if player has been assigned a struct
        if (get_Player(msg.sender) != false) {
            set_Player();
        }
        
        // Passes in the input and stores it for that particular player
        player_structs[msg.sender].guess = _Guess;

        Game();
    }

    function Game() internal {
        uint guess = player_structs[msg.sender].guess;
        uint attempts = player_structs[msg.sender].trials;

        if (attempts > 0) {
            if (guess > random_number) {
                console.log("Your guess was too big, Guess again");
            }

            else if (guess < random_number) {
                console.log("Your guess was too small, Guess again");
            }
            
            else if (guess == random_number && game_completion) {
                console.log("You got the number but the game has already been won");
            }

            else if (guess == random_number && !game_completion) {
                console.log("Congrats! You won the guess game first");
                winner = msg.sender;
                game_completion = true;
            }
        }

        else {
            console.log("You're out of attempts");
        }
    }
}