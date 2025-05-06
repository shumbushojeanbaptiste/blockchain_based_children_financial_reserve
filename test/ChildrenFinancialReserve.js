beforeEach(async function () {
    [guardian, child, other] = await ethers.getSigners();
    Reserve = await ethers.getContractFactory("ChildrenFinancialReserve");
    reserve = await Reserve.deploy();
    await reserve.waitForDeployment(); // FIX: Ethers v6 change
});
