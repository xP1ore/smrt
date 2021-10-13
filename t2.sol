//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.8.6;

// массив - упорядоченный набор данных одного типа
// виды массивов: статический/динамический (фиксированной/нефиксированной длины); массив чисел; массив строк; соответсвие (mapping); структура (struct); однемерный(вектор)/двумерный(матрица)
contract task2 {
    uint32[] a; //динамический однемерный массив
    uint32[4][2] b = [[22,3], [1,2], [12,12], [3,4]] //статический двумерный массив
    
    
    function getArrayLen() public view returns (uint) {
        return a.length;
    }
    
    function addNum(uint32 _n) public {
        a.push(_n);
    }
    
    function removeLastElem() public {
        
        a.pop();
        
    }
    
    function getArray() public view returns (uint32[] memory) {
        return a;
       
    }
    
    function removeSpecElem(uint16 _index) public returns (string memory) {
        string memory warn = "element was removed successfully";
        if (_index >= a.length) {
            warn = "index is out of length";
            return warn;
        }
        else {
            delete a[_index];
            
            for (uint i = _index; i < a.length-1; i++) {
                a[i] = a[i+1];
            }
            
            a.pop();
            return warn;
        }
    }
    
    
}
    