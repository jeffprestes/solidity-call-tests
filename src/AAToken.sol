// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC20/ERC20.sol";
import "openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// forge verify-contract --chain-id 5 --etherscan-api-key ${ETHERSCAN_API_KEY} 0x2d25a57924C7E22532E06d126f3115a0397478e4 src/AAToken.sol:AAToken
contract AAToken is ERC20, ERC20Burnable {
    constructor() ERC20("AAToken", "AATK") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public  {
        _mint(to, amount);
    }
}