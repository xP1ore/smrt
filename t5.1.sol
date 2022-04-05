//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.7.5;

contract T4_1 {

    T4_2 t4_2 = new T4_2(); 
    
    int n;
    
    function setVar(int _n) public {
        n = _n;    
    }
    
    function getString() public returns (string memory) {
        string memory a = t4_2.getString();
        return a;
    }
    
    function getModifiedVar() public returns (int) {
        int f = t4_2.someMathAction(n);
        return f;
    }

}

contract T4_2 {

    event IndexedLogStr(address indexed sender, string str);
    event IndexedLodVar(address indexed sender, int vat);
    
    function someMathAction(int n) external returns (int) {
        int k = n**2+int(n**5/100)-n;
        emit IndexedLodVar(msg.sender, k);
        return k;
    }
    
    function getString() external returns (string memory) {
        string memory _a = "Hello World";
        emit IndexedLogStr(msg.sender, _a);
        return _a;
    }
     
}