# Children Financial Reserve

A decentralized application (DApp) that allows parents to register their children, deposit funds, and manage financial reserves for their future. Built with **React**, **Solidity**, and **Ethers.js**, this project interacts with a smart contract deployed on an Ethereum-compatible blockchain.

---

## Features

- **Register Child**: Parents can register their child's wallet address, name, birth year, and release age.
- **Deposit Funds**: Deposit ETH into the child's financial reserve.
- **Withdraw Funds**: Withdraw funds when the child reaches the release age.
- **View Child Info**: Fetch and display child details and their financial balance.

---

## Prerequisites

Before running this project, ensure you have the following installed:

- **Node.js** (v14 or later)
- **npm** (Node Package Manager)
- **MetaMask** (Browser Extension)
- **Hardhat** (Ethereum development environment)

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/shumbushojeanbaptiste/children-financial-reserve.git
cd children-financial-reserve
```

### 2. Project Structure

```
children-financial-reserve/
├── contracts/                 # Solidity smart contracts
│   └── ChildrenFinancialReserve.sol
├── scripts/                   # Deployment scripts
│   └── deploy.js
├── children-frontend/         # React frontend
│   ├── src/
│   │   ├── App.js             # Main React component
│   │   ├── App.css            # Styling for the application
│   │   └── ChildrenFinancialReserve.json # ABI for the smart contract
│   └── public/
├── hardhat.config.js          # Hardhat configuration
└── README.md                  # Project documentation
```

---

### How to Use
1. Save this content as [README.md](http://_vscodecontentref_/3) in the root directory of your project.
2. Replace `0xYourDeployedContractAddress` with the actual deployed contract address.
3. Update the repository URL in the `git clone` command if applicable.

Let me know if you need further assistance!