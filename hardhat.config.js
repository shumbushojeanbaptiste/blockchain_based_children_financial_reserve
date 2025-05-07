require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.0", // Must match your pragma version
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
      chainId: 31337
    }
  }
};