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

    function depositFunds(address _child) external payable {
        require(children[_child].registered, "Child not registered");
        require(msg.value > 0, "No funds sent");
        children[_child].balance += msg.value;
        emit FundsDeposited(_child, msg.value);
    }

    function withdrawFunds() external {
        Child storage child = children[msg.sender];
        require(child.registered, "Not registered");
        uint256 currentAge = getYear() - child.birthYear;
        require(currentAge >= child.releaseAge, "Too early to withdraw");
        require(child.balance > 0, "No funds available");

        uint256 amount = child.balance;
        child.balance = 0;
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
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
