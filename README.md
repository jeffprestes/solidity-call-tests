# Account Abstraction Lite

Test project to show solidity calls to test Account Abstraction transfering tokens

## Foundry

This project uses Foundry : https://book.getfoundry.sh/

## Scripts

### Deploy

```bash
forge script script/Deploy.s.sol:DeployScript --broadcast --verify --rpc-url ${RPC_URL} --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
```

### EntryPoint load/transfer simuation

```bash
forge script script/LoadAccount.s.sol:LoadAccount --broadcast --rpc-url ${RPC_URL} -vvvv
```