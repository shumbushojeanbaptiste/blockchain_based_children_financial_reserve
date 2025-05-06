// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChildrenFinancialReserve {
    struct ChildReserve {
        address guardian;
        string name;
        uint birthYear;
        uint releaseAge;
        uint balance;
        bool exists;
    }

    struct ChildBasicInfo {
        address guardian;
        string name;
        uint birthYear;
        uint releaseAge;
        uint balance;
    }
    
    struct ChildStatusInfo {
        uint currentAge;
        bool withdrawAvailable;
    }

    mapping(address => ChildReserve) private _childReserves;
    address[] private _registeredChildren;

    event ChildRegistered(address childAddress, address guardian, string name, uint birthYear, uint releaseAge);
    event DepositMade(address childAddress, uint amount);
    event Withdrawal(address childAddress, uint amount);

    modifier onlyGuardian(address childAddress) {
        require(_childReserves[childAddress].guardian == msg.sender, "Only the guardian can perform this action");
        _;
    }

    modifier onlyChildOrGuardian(address childAddress) {
        require(
            childAddress == msg.sender || _childReserves[childAddress].guardian == msg.sender,
            "Only the child or guardian can perform this action"
        );
        _;
    }

    modifier reserveExists(address childAddress) {
        require(_childReserves[childAddress].exists, "Child reserve does not exist");
        _;
    }

    function registerChild(
        address childAddress,
        string memory name,
        uint birthYear,
        uint releaseAge
    ) external {
        require(!_childReserves[childAddress].exists, "Child already registered");
        require(childAddress != address(0), "Invalid child address");
        require(releaseAge > 0, "Release age must be greater than 0");
        require(birthYear > 1900 && birthYear <= block.timestamp, "Invalid birth year");

        _childReserves[childAddress] = ChildReserve({
            guardian: msg.sender,
            name: name,
            birthYear: birthYear,
            releaseAge: releaseAge,
            balance: 0,
            exists: true
        });

        _registeredChildren.push(childAddress);
        emit ChildRegistered(childAddress, msg.sender, name, birthYear, releaseAge);
    }

    function deposit(address childAddress) external payable reserveExists(childAddress) onlyGuardian(childAddress) {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        _childReserves[childAddress].balance += msg.value;
        emit DepositMade(childAddress, msg.value);
    }

    function getCurrentAge(address childAddress) public view reserveExists(childAddress) returns (uint) {
        uint currentYear = getYear(block.timestamp);
        return currentYear - _childReserves[childAddress].birthYear;
    }

    function canWithdraw(address childAddress) public view reserveExists(childAddress) returns (bool) {
        return getCurrentAge(childAddress) >= _childReserves[childAddress].releaseAge;
    }

    function withdraw() external reserveExists(msg.sender) {
        require(canWithdraw(msg.sender), "Child has not reached the release age yet");
        uint amount = _childReserves[msg.sender].balance;
        require(amount > 0, "No funds available to withdraw");

        _childReserves[msg.sender].balance = 0;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getChildBasicInfo(address childAddress) 
        external 
        view 
        reserveExists(childAddress) 
        returns (ChildBasicInfo memory info)
    {
        ChildReserve storage reserve = _childReserves[childAddress];
        info.guardian = reserve.guardian;
        info.name = reserve.name;
        info.birthYear = reserve.birthYear;
        info.releaseAge = reserve.releaseAge;
        info.balance = reserve.balance;
        return info;
    }
    
    function getChildStatusInfo(address childAddress)
        external
        view
        reserveExists(childAddress)
        returns (ChildStatusInfo memory status)
    {
        status.currentAge = getCurrentAge(childAddress);
        status.withdrawAvailable = canWithdraw(childAddress);
        return status;
    }

    function getRegisteredChildrenCount() external view returns (uint) {
        return _registeredChildren.length;
    }

    function getChildReserve(address childAddress) 
        external 
        view 
        returns (
            bool exists,
            address guardian,
            uint balance
        )
    {
        ChildReserve storage reserve = _childReserves[childAddress];
        return (
            reserve.exists,
            reserve.guardian,
            reserve.balance
        );
    }

    function getYear(uint timestamp) internal pure returns (uint) {
        return 1970 + timestamp / 31556926;
    }
}