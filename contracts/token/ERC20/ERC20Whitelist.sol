pragma solidity ^0.5.0;

import "../../GSN/Context.sol";
import "./IERC20.sol";
import "../../math/SafeMath.sol";
import "./ERC20.sol";
import "../../access/roles/WhitelistAdminRole.sol";

contract ERC20Whitelist is ERC20, WhitelistAdminRole {

    // whitelisted or blacklisted accounts
    mapping (address => bool) whitelist;

    // owner: can do whitelist or blacklist
    address whitelistadmin;

    function setWhiteList(address _toSet, bool _whiteOrBlacklisted) public onlyWhitelistAdmin() {
        whitelist[_toSet] = _whiteOrBlacklisted;
    }

    // at transfer both the sender and the recipient has to be whitelisted
    function _transfer(address sender, address recipient, uint256 amount) internal {
        // KYC checks
        require(whitelist[sender] == true, "Sender account is not whitelisted");
        require(whitelist[recipient] == true, "Recipient account is not whitelisted");

        // Base functionality
        super._transfer(sender, recipient, amount);
    }

    // at mint the address account has to be whitelisted
    function _mint(address account, uint256 amount) internal {
        require(whitelist[account] == true, "The account is not whitelisted");

        // Base functionality
        super._mint(account, amount);
    }

    // at mint the address account has to be whitelisted
    function _burn(address account, uint256 amount) internal {
        require(whitelist[account] == true, "The account is not whitelisted");

        // Base functionality
        super._burn(account, amount);
    }

    // at approve both the owner and the spender have to be whitelisted
    function _approve(address owner, address spender, uint256 amount) internal {
        require(whitelist[owner] == true, "The owner account is not whitelisted");
        require(whitelist[spender] == true, "The spender account is not whitelisted");

        // Base functionality
        super._approve(owner, spender, amount);
    }

    // at burnFrom the account has to be whitelisted
   function _burnFrom(address account, uint256 amount) internal {
        require(whitelist[account] == true, "The account is not whitelisted");

        // Base functionality
        super._burnFrom(account, amount);
    }


}
