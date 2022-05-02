const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Guess", function () {
  it("Should allow the user guess the number", async function () {
    const Guess_Game = await ethers.getContractFactory("Guess_Game");
    const guess_game = await Guess_Game.deploy();
    await guess_game.deployed();

    expect(await guess_game.get_number()).to.lessThanOrEqual(100);

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
