pragma solidity ^0.4.19;

    /******--------------------- ROPSTEN TESTNET VERSION /!\ ATTENTION ROPSTEN ONLY ---------------------*******/
                

            /*------------------------------------------------------------------------------/*
            ** THIS CONTRACT RETURNS A 99% SAFE RANDOM NUMBER WITHOUT THE USE OF AN ORACLE  **
            /*------------------------------------------------------------------------------*/

/**
 *                                           *--- PROCESS ---*
 *          1 - UnsecureRandom number is calculated mixing msg.sender address to block.timestamp
 *          2 - The result is then analysed and distributed to a specific hidden algorythm 
 *          3 - algorythms.sol contains 10 different algorythms ready to receive an uint and change it
 *              (these algorythms remain hidden from public with the use of contract import and no one can reach them)
 *          4 - This file finally returns a totally safe random uint to the user without burning any gas nor using an external oracle.
 *
 * Use :   Simply import SafeRandomnessRopsten.sol to your smart contract and call "generateSafeRand()" to get you random number. 
 * Note :  function returns only one result per block. The result is different for each msg.sender 
**/

// Algorythms are kept hidden from public - We use an interface instead :
contract AlgoInterface {
    function executeAlgo1(uint _rand) view returns(uint);
    function executeAlgo2(uint _rand) view returns(uint);
    function executeAlgo3(uint _rand) view returns(uint);
    function executeAlgo4(uint _rand) view returns(uint);
    function executeAlgo5(uint _rand) view returns(uint);
    function executeAlgo6(uint _rand) view returns(uint);
    function executeAlgo7(uint _rand) view returns(uint);
    function executeAlgo8(uint _rand) view returns(uint);
    function executeAlgo9(uint _rand) view returns(uint);
    function executeAlgo10(uint _rand) view returns(uint);
}

contract SafeRandomness {
    AlgoInterface algo;
    
    function SafeRandomness() {
        algo = AlgoInterface(0x2a1f1c48a3cb6cda970424254f7a65b4d9f53562);   // address of hidden algorythms.sol (Ropsten TESTNET)
    }
    
  function _unsecureRandomNum(uint _randomDigits) internal view returns(uint result) {
        uint rand = (uint(keccak256(now, _randomDigits)));
        return rand;
    }
      
    function _pickRandomAlgorythm() internal view returns(uint) {
        uint rand = (_unsecureRandomNum(uint8(msg.sender)))%100;
        uint num = _unsecureRandomNum(uint8(msg.sender));
       
        if (rand <= 10) 
        return algo.executeAlgo1(num);
         if (rand <= 20) 
         return algo.executeAlgo2(num);
          if (rand <= 30) 
          return algo.executeAlgo3(num);
           if (rand <= 40) 
           return algo.executeAlgo4(num);
            if (rand <= 50) 
            return algo.executeAlgo5(num);
             if (rand <= 60) 
             return algo.executeAlgo6(num);
              if (rand <= 70) 
              return algo.executeAlgo7(num);
               if (rand <= 80) 
               return algo.executeAlgo8(num);
                if (rand <= 90) 
                return algo.executeAlgo9(num);
                 if (rand <= 100) 
                 return algo.executeAlgo10(num);
    }
    
    function generateSafeRand() internal view returns (uint){
        
         uint result = _pickRandomAlgorythm();
         
         while (result == 0) {
             result += _pickRandomAlgorythm();
         }
         return result;
    }
    
}


