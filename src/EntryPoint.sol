// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./Exec.sol";

contract EntryPointLite {

  address public account;

  function changeAccount(address _account) external returns(bool) {
    require(_account!= address(this), "Cannot set self as new entry point");
    account = _account;
    return true;
  }

  function callTransfer(bytes calldata _param) external returns (bool) {
    bool success = Exec.call(account, 0, _param, gasleft());
    return success;
  }

}