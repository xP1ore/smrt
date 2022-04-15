//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.8.6;
pragma abicoder v2;

contract T7 {
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

    uint32[] public a;
    string[] public str;

    function addNum(uint32 _n) public{
        a.push(_n);
    }
    
    function increaseNums(uint32 _k) public{
        uint32 i = 0;
        while (i < a.length) {
            a[i] += _k;
            i++;
        }
    }

    function addStr(string memory _str) public {
        str.push(_str);
    }

    function strConcat(string memory _a, string memory _b) pure internal returns (string memory) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }

    function concatToStrs(string memory _str) public {
        for (uint32 i = 0; i < str.length; i++) {
            str[i] = strConcat(str[i], _str);
        }
    }
 
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
            balances[msg.sender] -= _amount;
            _to.transfer(_amount);
            emit Sending(msg.sender, _to, _amount);
            transactionStatus = TransactionStatus.Sent;
            Transaction memory withdraw = Transaction(owner, msg.sender, transactionStatus, _amount);
            transactions.push(withdraw);
        }
        else {
            require((balances[msg.sender]) >= (_amount), "overflow issue");
            balances[msg.sender] -= _amount;
            bool sent = _to.send(_amount);
            require(sent, "failed to send ETH");
            emit Sending(msg.sender, _to, _amount);
            transactionStatus = TransactionStatus.Sent;
            Transaction memory withdraw = Transaction(_to, msg.sender, transactionStatus, _amount);
            transactions.push(withdraw);
        }
    }
}