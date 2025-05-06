const hre = require("hardhat");

async function main() {
    const ChildrenFinancialReserve = await hre.ethers.getContractFactory("ChildrenFinancialReserve");
    const reserve = await ChildrenFinancialReserve.deploy();
    await reserve.waitForDeployment(); // <- use this instead of `.deployed()`

    console.log("ChildrenFinancialReserve deployed to:", await reserve.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
