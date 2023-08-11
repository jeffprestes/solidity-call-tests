// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./Account.sol";

contract EntryPointLite {

  address payable public accountAddress;
  Accountz public account;
  address public tokenAddress;

  function changeAccount(address payable _accountAddress) external returns(bool) {
    require(_accountAddress!= address(this), "Cannot set self as new entry point");
    accountAddress = _accountAddress;
    account = Accountz(accountAddress);
    return true;
  }

  function changeTokenAddress(address _tokenAddress) external returns(bool) {
    require(_tokenAddress!= address(this), "Cannot set self as new entry point");
    tokenAddress = _tokenAddress;
    return true;
  }

  function call(bytes memory _param) external returns (bool) {
    (bool success, ) = account.call(tokenAddress, 0, _param);
    return success;
  }

}