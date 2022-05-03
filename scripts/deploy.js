async function main() {
    const Guess_Game = await ethers.getContractFactory("Guess_Game");
   
    // Start deployment, returning a promise that resolves to a contract object
    const guess_game = await Guess_Game.deploy(); 
    console.log("Contract deployed to address:", guess_game.address);
   }
   
   main()
    .then(() => process.exit(0))
    .catch(error => {
    console.error(error);
    process.exit(1);
    });