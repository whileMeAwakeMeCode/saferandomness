pragma solidity ^0.4.19;

/*  @title  - SAFERANDOMNESS -
*   @dev    - Mathieu Lecoq
*/

            /*----------------------------------------------------------------------------------/*
            ** THIS CONTRACT RETURNS A 99% SAFE RANDOM UINT NUMBER WITHOUT THE USE OF AN ORACLE **
            /*----------------------------------------------------------------------------------*/

/**
 *                                              *--- PROCESS ---*
 *          1 - UnsecureRandom number is calculated mixing msg.sender address to block.timestamp
 *          2 - The result is then analysed and distributed to a specific hidden algorythm 
 *          3 - algorythms.sol contains 10 different algorythms ready to receive an uint and change it
 *              (these algorythms remain hidden from public with the use of contract import and no one can reach them)
 *          4 - This file finally returns a totally safe random uint to the user without burning any gas nor using an external oracle. 
**/

import "./algorythms.sol";      // Algorythms are kept hidden from public 

contract SafeRandomness is Algorythms {
    
    
    
  function _unsecureRandomNum(uint _randomDigits) internal view returns(uint result) {
        uint rand = (uint(keccak256(now, _randomDigits)));
        return rand;
    }
       

    function _pickRandomAlgorythm() internal view returns(uint) {
        uint rand = (_unsecureRandomNum(uint8(msg.sender)))%100;
       
        if (rand <= 10) 
        return executeAlgo1(_unsecureRandomNum(uint8(msg.sender)));
         if (rand <= 20) 
         return executeAlgo2(_unsecureRandomNum(uint8(msg.sender)));
          if (rand <= 30) 
          return executeAlgo3(_unsecureRandomNum(uint8(msg.sender)));
           if (rand <= 40) 
           return executeAlgo4(_unsecureRandomNum(uint8(msg.sender)));
            if (rand <= 50) 
            return executeAlgo5(_unsecureRandomNum(uint8(msg.sender)));
             if (rand <= 60) 
             return executeAlgo6(_unsecureRandomNum(uint8(msg.sender)));
              if (rand <= 70) 
              return executeAlgo7(_unsecureRandomNum(uint8(msg.sender)));
               if (rand <= 80) 
               return executeAlgo8(_unsecureRandomNum(uint8(msg.sender)));
                if (rand <= 90) 
                return executeAlgo9(_unsecureRandomNum(uint8(msg.sender)));
                 if (rand <= 100) 
                 return executeAlgo10(_unsecureRandomNum(uint8(msg.sender)));
                 
                 
        
    }
    
    function generateSafeRand() public view returns (uint){
        
         uint result = _pickRandomAlgorythm();
         
         while (result == 0) {
             result += _pickRandomAlgorythm();
         }
         if (result > 0) 
         return result;
         else return _pickRandomAlgorythm();
        }
    
}

