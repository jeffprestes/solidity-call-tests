// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "../src/AAToken.sol";
import "../src/EntryPoint.sol";
import "../src/Account.sol";
import "./Utils.sol";


// forge script script/LoadAccount.s.sol:LoadAccount --broadcast --rpc-url ${RPC_URL} -vvvv
contract LoadAccount is Script {

  AAToken public token;
  address public tokenAddress;
  Accountz public account;
  address payable public accountAddress;  
  EntryPointLite public entryPoint;
  address public entryPointAddress;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);
    setUp();
    bool success = entryPoint.call(hex"a9059cbb0000000000000000000000005f8b6a05dd8c9b71242b7fa3fdbe675f6723ead80000000000000000000000000000000000000000000000000de0b6b3a7640000");
    vm.stopBroadcast();
    console.log("OK? %s", success);
  }

  function setUp() internal {
    string memory tokenAddressStr = vm.readFile("token-address.txt");
    tokenAddress = StringToAddress.convert(tokenAddressStr);
    token = AAToken(tokenAddress);
    string memory accountAddressStr = vm.readFile("account-address.txt");
    accountAddress = payable(StringToAddress.convert(accountAddressStr));
    account = Accountz(accountAddress);
    string memory entryPointAddressStr = vm.readFile("entrypoint-address.txt");
    entryPointAddress = StringToAddress.convert(entryPointAddressStr);
    entryPoint = EntryPointLite(entryPointAddress);
    (string memory name, string memory symbol, uint256 balance) = account.tokenData();
    console.log("Token data: %s - %s - Balance: %s", name, symbol, balance);
    console.log("Balance %d", token.balanceOf(accountAddress));
  }

}