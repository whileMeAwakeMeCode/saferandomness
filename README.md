# saferandomness

For ROPSTEN TESTNET USE : 

import "http://github.com/whileMeAwakeMeCode/saferandomness/SafeRandomnessRopsten.sol";
inherit : "YourContract is SafeRandomness"
call function generateSafeRand() 

For MAINNET USE :

import "http://github.com/whileMeAwakeMeCode/saferandomness/SafeRandomness.sol";
inherit : "YourContract is SafeRandomness"
call function generateSafeRand()

# safeRandomnessV2

This "module" is designed to failsafe any "zero" response. 

/!\ randomness.sol must remain hidden from public and imported through a contract interface :
- saferandomness.sol          // this contract MUST be imported instead, this way, algorythms are kept secret. 

Usage :
1 - Deploy Randomness from randomness.sol
2 - Add Randomness contract address to randomnessinterface.sol, contract Randomness, function constructor instead of :
/*YOUR_RANDOM_CONTRACT_ADDRESS* 

// example :
securize = RandomnessInterface(
0x61e97835ae745bf6e3afca6e45a6506bc2b0132
);

3 - Deploy Randomness from randomnessinterface.sol and use THIS contract to get a random with random()


by : Mathieu L.
matsolidity@gmail.com
