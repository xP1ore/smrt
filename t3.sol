pragma solidity 0.7.5;

contract t3 {
    
    // создаем словарь с адресом в виде ключа и строкой с описание типа депозита в виде значения для ключа
    mapping(address => string) public Deps;
    
    // ф-ия возвращает тип депозита, который соответствует определенному адресу
    function getDepTypeByAddr(address _addr) public view returns(string memory) {
        string memory _a = "";
        string memory _warn = "";
        if (bytes(Deps[_addr]).length != bytes(_a).length) {
            return(Deps[_addr]);
        }
        else {
            _warn = "address is not found";
            return _warn;
        }
    }
    
    // ф-ия доабавляет определенному адресу соответствующий ему тип депозита
    function setDepTypeForAddr(address _addr, string memory _str) public {
        Deps[_addr] = _str;
    }
    
    // ф-ия удаляет адрес из словаря
    function rmvAddr(address _addr) public {
        delete Deps[_addr];
    }
}