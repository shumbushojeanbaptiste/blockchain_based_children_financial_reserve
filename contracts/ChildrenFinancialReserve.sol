// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChildrenFinancialReserve {
    struct Child {
        string name;
        uint256 birthYear;
        uint256 releaseAge;
        uint256 balance;
        bool registered;
    }

    mapping(address => Child) public children;

    event ChildRegistered(address indexed child, string name, uint256 releaseAge);
    event FundsDeposited(address indexed child, uint256 amount);
    event FundsWithdrawn(address indexed child, uint256 amount);

   function isChildRegistered(address _child) public view returns (bool) {
    return children[_child].registered;
}
    function registerChild(address _child, string memory _name, uint256 _birthYear, uint256 _releaseAge) external {
        require(!children[_child].registered, "Child already registered");
        children[_child] = Child({
            name: _name,
            birthYear: _birthYear,
            releaseAge: _releaseAge,
            balance: 0,
            registered: true
        });
        emit ChildRegistered(_child, _name, _releaseAge);
    }

   event TransactionRecorded(
    address indexed from,
    address indexed to,
    uint256 amount,
    string transactionType,
    uint256 timestamp
);

function depositFunds(address _child) public payable {
    require(children[_child].registered, "Child not registered");
    children[_child].balance += msg.value;

    emit TransactionRecorded(msg.sender, _child, msg.value, "Deposit", block.timestamp);
}

function withdrawFunds(uint256 _amount) public {
    require(children[msg.sender].registered, "Child not registered");
    require(children[msg.sender].balance >= _amount, "Insufficient balance");

    children[msg.sender].balance -= _amount;
    payable(msg.sender).transfer(_amount);

    emit TransactionRecorded(address(this), msg.sender, _amount, "Withdrawal", block.timestamp);
}

    function getYear() public view returns (uint256) {
        // Approximate year
        return (block.timestamp / 31556926) + 1970; // 31556926 seconds/year
    }

   function getChild(address _child) public view returns (
    string memory name,
    uint256 birthYear,
    uint256 releaseAge,
    uint256 balance,
    bool registered
) {
    require(children[_child].registered, "Child not registered");
    Child memory child = children[_child];
    return (child.name, child.birthYear, child.releaseAge, child.balance, child.registered);
}

    
}
