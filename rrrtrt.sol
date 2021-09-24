//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.8.6;

// заранее заданы 2 числа (К первому можно только прибавлять, из второго - только вычитать). Пользователю нужно поменять их местами. Он также может предположить с какой попытки ему это удастся
contract task1 {
    
    // задаются числа 
    uint8 a1 = 255; 
    uint8 a2 = 0;
    
    
    uint16 k1 = 0; //счетчик попыток
    uint16 k2 = 0; //кол-во попыток, которое предполагает пользователь
    
    string a = "";
    
    
    //здесь принимаются числа пользователя
    function setUserNumbers(uint8 _a1, uint8 _a2) public {
        a1 = a1 + _a1;
        a2 = a2 - _a2;
        k1 += 1;

    }
    
    //функция позволяет посмотреть загаданные числа
    function getResults() public view returns(uint8, uint8) {
        return (a1, a2);
    }
    
    //получает предположение пользователя
    function setUserPrediction(uint16 _k2) public {
        k2 = _k2;
    }
    
    //возвращает количество попыток, предпринятых пользователем
    function getTries() public view returns(uint16) {
        return k1;
    }
    
    //проверяет, прав ли был пользователь, предполагая кол-во попыток
    function getResult() public returns(string memory) {
        if (k2 <= k1) 
            a = "U right";
        else 
            a = "U wrong";
        return a;
        
    }
}