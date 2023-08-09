// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./Exec.sol";
import "openzeppelin/contracts/interfaces/IERC20Metadata.sol";

contract Accountz {

  IERC20Metadata public mytoken;

  constructor(address _mytokenAddress) {
    mytoken = IERC20Metadata(_mytokenAddress);
  }

  function tokenData() external view returns (string memory, string memory, uint256) {
    return (mytoken.name(), mytoken.symbol(), mytoken.balanceOf(address(this)));
  }

  function transfer(address _beneficiary, uint256 _amount) external {
    mytoken.transfer(_beneficiary, _amount);
  }

}