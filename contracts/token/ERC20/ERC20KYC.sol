pragma solidity ^0.5.0;

import "../../GSN/Context.sol";
import "./IERC20.sol";
import "../../math/SafeMath.sol";
import "./ERC20.sol";


contract ERC20KYC is ERC20 {

    // whitelisted or blacklisted accounts
    mapping (address => bool) whitelist;

    // owner: can do whitelist or blacklist
    address whitelistadmin;

    constructor() public {
        whitelistadmin = msg.sender;
    }

    modifier isWhitwListAdmin() {
        require(msg.sender == whitelistadmin,"only whitelistadmin can administrate the whitelist");
        _;
    }

    function setWhiteList(address _toSet, bool _whiteOrBlacklisted) isWhitwListAdmin() public {
        whitelist[_toSet] = _whiteOrBlacklisted;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(whitelist[sender] == true, "Sender account is not whitelisted");
        require(whitelist[recipient] == true, "Recipient account is not whitelisted");
        super._transfer(sender, recipient, amount);
    }
}
