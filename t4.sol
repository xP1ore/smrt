pragma solidity 0.7.5;

contract T4_1 {

    T4_2 t4_2 = new T4_2(); 
    
    int n;
    
    function setVar(int _n) public {
        n = _n;    
    }
    
    function getString() public view returns (string memory) {
        string memory a = t4_2.getString();
        return a;
    }
    
    function getModifiedVar() public view returns (int) {
        int f = t4_2.someMathAction(n);
        return f;
    }

}

contract T4_2 {
    
    function someMathAction(int n) external pure returns (int) {
        int k = n**2+int(n**5/100)-n;
        return k;
    }
    
    function getString() external pure returns (string memory) {
        string memory _a = "Hello World";
        return _a;
    }
     
}