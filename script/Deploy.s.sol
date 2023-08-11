// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "../src/AAToken.sol";
import "../src/EntryPoint.sol";
import "../src/Account.sol";


// forge script script/Deploy.s.sol:DeployScript --broadcast --verify --rpc-url ${RPC_URL} --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
// forge script script/Deploy.s.sol:DeployScript --broadcast --rpc-url ${RPC_URL}
contract DeployScript is Script {

  AAToken public token;
  address public tokenAddress;
  Accountz public account;
  address payable public accountAddress;
  EntryPointLite public entryPoint;

  function deployToken() public {
    token = new AAToken();
    tokenAddress = address(token);
  }

  function deployEntryPoint() public {
    entryPoint = new EntryPointLite();
    entryPoint.changeAccount(accountAddress);
    entryPoint.changeTokenAddress(tokenAddress);
  }

  function deployAccount() public {
    account = new Accountz(tokenAddress);
    accountAddress = payable(address(account));
    token.mint(accountAddress, 1000 * 10 ** token.decimals());
  }

  function run() public {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);
    deployToken();
    deployAccount();
    deployEntryPoint();
    vm.stopBroadcast();
    vm.writeFile("./token-address.txt", vm.toString(tokenAddress));
    vm.writeFile("./account-address.txt", vm.toString(accountAddress));
    vm.writeFile("./entrypoint-address.txt", vm.toString(address(entryPoint)));
    console.log("token: %s - account: %s - entryPoint: %s", tokenAddress, accountAddress, address(entryPoint));
  }
}