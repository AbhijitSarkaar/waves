const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy(
      {
        value: hre.ethers.utils.parseEther("0.1"),
      }
    );
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave('Wave #1');
    await waveTxn.wait();

     waveTxn = await waveContract.wave('Wave #2');
    await waveTxn.wait();

     waveTxn = await waveContract.wave('Wave #3');
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();
    
    waveTxn = await waveContract.connect(randomPerson).wave('Wave #4');
    await waveTxn.wait();

    /*
   * Get Contract balance to see what happened!
   */
    const contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );
  
    const allWaves = await waveContract.getAllWaves();
    console.log(allWaves)
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();