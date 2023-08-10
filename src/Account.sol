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

  receive() external payable {}

  function call(address target, uint256 value, bytes memory data) external returns (bool, bytes memory) {
    (bool success, bytes memory result) = target.call{value : value}(data);
    if (!success) {
        assembly {
            revert(add(result, 32), mload(result))
        }
    }
    return (success, result);
  }

}