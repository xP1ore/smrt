//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.5;
pragma abicoder v2;

contract T6 {
    event Receiving(address indexed _from, uint _value);
    event Sending (address indexed _from, address indexed _to, uint _value);

    enum TransactionStatus {
        None,
        Sent,
        Received,
        Cancelled
    }

    TransactionStatus public transactionStatus;

    struct Transaction {
        address to;
        address from;
        TransactionStatus transactionStatus;
        uint amount;
    }

    Transaction[] public transactions;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) public balances;

    receive() external payable {
        balances[msg.sender] += msg.value;
        emit Receiving(msg.sender, msg.value);
        transactionStatus = TransactionStatus.Received;
        Transaction memory income = Transaction(address(this), msg.sender, transactionStatus, msg.value);
        transactions.push(income);

    }

    function getTransactions(uint _n) view public returns (Transaction memory) {
        return transactions[_n];
    }

    function setTransaction(address _to, address _from, TransactionStatus _transactionStatus, uint _amount) public {
        transactions.push(Transaction(_to, _from, _transactionStatus, _amount));
    }

    function sendEther(address payable _to, uint _amount) external {
        if (_to == owner) {
            require((balances[msg.sender]) >= (_amount), "overflow issue");
            _to.transfer(_amount);
            balances[msg.sender] -= _amount;
            emit Sending(msg.sender, _to, _amount);
            transactionStatus = TransactionStatus.Sent;
            Transaction memory withdraw = Transaction(owner, msg.sender, transactionStatus, _amount);
            transactions.push(withdraw);
        }
        else {
            require((balances[msg.sender]) >= (_amount), "overflow issue");
            bool sent = _to.send(_amount);
            require(sent, "failed to send ETH");
            balances[msg.sender] -= _amount;
            emit Sending(msg.sender, _to, _amount);
            transactionStatus = TransactionStatus.Sent;
            Transaction memory withdraw = Transaction(_to, msg.sender, transactionStatus, _amount);
            transactions.push(withdraw);
        }
    }
}