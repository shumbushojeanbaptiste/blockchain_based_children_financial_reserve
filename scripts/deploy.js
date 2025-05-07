const hre = require("hardhat");

async function main() {
  const CFR = await hre.ethers.getContractFactory("ChildrenFinancialReserve");

  const cfr = await CFR.deploy(); // This deploys and returns the instance
  await cfr.waitForDeployment(); // Use waitForDeployment() instead of deployed()

  console.log(`ChildrenFinancialReserve deployed at ${await cfr.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
