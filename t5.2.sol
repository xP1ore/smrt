//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.5;

contract T5 {
    event Receiving(address indexed _from, uint _value);
    event Sending (address indexed _from, address indexed _to, uint _value);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) public balances;

    receive() external payable {
        balances[msg.sender] += msg.value;
        emit Receiving(msg.sender, msg.value);
    }

    function sendEther(address payable _to, uint _amount) external {
        if (_to == owner) {
            require((balances[msg.sender]) >= (_amount), "overflow issue");
            _to.transfer(_amount);
            balances[msg.sender] -= _amount;
            emit Sending(msg.sender, _to, _amount);
        }
        else {
            require((balances[msg.sender]) >= (_amount), "overflow issue");
            bool sent = _to.send(_amount);
            require(sent, "failed to send ETH");
            balances[msg.sender] -= _amount;
            emit Sending(msg.sender, _to, _amount); 
        }
    }
}