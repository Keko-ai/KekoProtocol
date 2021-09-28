// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

interface IKAsset is IERC20, IERC20Metadata{
    function setDetails(string memory name_, string memory symbol_) external;
    function mint(address account, uint256 amount) external;
    function burn(uint256 amount) external;
}