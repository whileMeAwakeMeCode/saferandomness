pragma solidity ^0.4.21;

                        /*******************| RANDOMNESS (safeRandomness v2) |*******************/
                    /*------------------------------------------------------------------/*
                    ** THIS CONTRACT MUST BE KEPT HIDDEN FROM PUBLIC FOR SAFETY REASONS **
                    /*------------------------------------------------------------------*/
                 
import "./safemath.sol";

/* Algorythms examples */

contract Algorythms {
    using SafeMath for uint256;
    
    function executeAlgo1(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%1000)/10;
        return result;
    }
    
    function executeAlgo2(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%100000)/1000;
        return result.add(1);
    }
    
    function executeAlgo3(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%10000000)/100000;
        return result.add(1);
    }
    
    function executeAlgo4(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%100000000)/1000000;
        return result.add(1);
    }
    
    function executeAlgo5(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%10000000000)/100000000;
        return result.add(1);
    }
    
    function executeAlgo6(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%1000000000000)/10000000000;
        return result.add(1);
    }
    
    function executeAlgo7(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand%100);
        return result.add(1);
    }
    
    function executeAlgo8(uint _rand) internal pure returns(uint) {
        
        uint result = (_rand^_rand)%100;
        return result.add(1);
    }
    
    function executeAlgo9(uint _rand) internal pure returns(uint) {
        
        uint result = uint8(_rand) / 1000000;
        return result.add(1);
    }
    
    function executeAlgo10(uint _rand) internal view returns(uint) {
        
        uint result = (_rand * now / 2)%100;
        return result.add(1);
    }
    
}


contract Randomness is Algorythms {

    function _secure(uint _randomDigits) private view returns(uint success) {
        uint rand = uint(keccak256(now, _randomDigits));
        return(_pickRandomAlgorythm(rand));
    }
    
    
    function _pickRandomAlgorythm(uint _rand) private view returns(uint) {

        uint num = _rand + (uint8(msg.sender));
        uint rand = num % 100;
        
        if (rand <= 10) 
        return executeAlgo1(num);

        if (rand <= 20) 
        return executeAlgo2(num);

        if (rand <= 30) 
        return executeAlgo3(num);

        if (rand <= 40) 
        return executeAlgo4(num);

        if (rand <= 50) 
        return executeAlgo5(num);

        if (rand <= 60) 
        return executeAlgo6(num);

        if (rand <= 70) 
        return executeAlgo7(num);

        if (rand <= 80) 
        return executeAlgo8(num);
        
        if (rand <= 90) 
        return executeAlgo9(num);

        if (rand <= 100) 
        return executeAlgo10(num);
    }
    

    function secureUnsecure(uint _unsecure) private view returns (uint result){
        
            result = _secure(_unsecure);
            
            if (result == 0) {
                result = result.add(uint(keccak256(now ^ 2, msg.sender)));
            }
            if (result == 0) {
                result = failSafe(); 
            }
            return result;
    } 
    
    

 
    
    
    
    function bytes32ToString(bytes32 x) internal pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
            
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
            }
            
        return string(bytesStringTrimmed);
    }
    
    
    function hash (string toHash, bytes32 hashCode) public pure returns (bytes32) {
    bytes32 hval;
    bytes32 result;
    uint rand;
    bytes32 sResult;
    
        if (keccak256(hashCode) == keccak256('0')) {
            hval = '0x117a3fb1d91c028d2';
        } else hval = hashCode;
        
        result = keccak256(toHash, hval);
        rand = uint(result) % 5;
        
        sResult =  result >> rand;
        return sResult;
    }
    
    function failSafe2(uint _unsecure, uint _modulo) internal pure returns (uint secure) {
        uint result = uint(hash(bytes32ToString(bytes32(_unsecure)), 0));
        return (result % _modulo);
    }
    
    function failSafe() private view returns (uint) {
        uint rand = uint(keccak256(now.div(now), msg.sender));
        if (rand > 0)
        return  _pickRandomAlgorythm(rand);
        else return secureUnsecure(7789);
    }
    
    function random(uint _unsecure, uint _modulo) public view returns (uint result) {
        _unsecure = _unsecure.add(1);
        uint base = secureUnsecure(_unsecure);
        uint multip = base.add(2).mul(base);
        uint loop = multip.mul(multip);
        
        // handle modulo error zero issue :
        uint multiply = base.add(1).mul(multip.mul(loop));
        
        if (multiply != 0) 
            result = (multiply % _modulo);
        else result = ((loop.add(now)) % _modulo);
        
        if (result <= 0) return failSafe2(_unsecure, _modulo);
        else return result;
    }
}

