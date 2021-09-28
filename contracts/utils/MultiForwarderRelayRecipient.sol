// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// The goal here to avoid Biconomy lock in, so we can potentially integrate OpenGSN as a backup service. Uptime is everything.

import "./IRelayRecipient.sol";
import "./IForwarderRegistry.sol";

abstract contract MultiForwarderRelayRecipient is IRelayRecipient{

    //default forwarder
    address private defaultForwarderAddress;

    //address of registry that gives backup forwarder addresses
    address public forwarderRegistryAddress;

    function isTrustedForwarder(address forwarder) public virtual override view returns(bool) {
        return 
        (forwarder == defaultForwarderAddress) || 
        (IForwarderRegistry(forwarderRegistryAddress).isRegistedForwarder(forwarder));
    }

    function _setDefaultForwarder(address _forwarder) internal {
        defaultForwarderAddress = _forwarder;
    }

    function _msgSender() internal override virtual view returns (address ret) {
        if (msg.data.length >= 20 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // so we trust that the last bytes of msg.data are the verified sender address.
            // extract sender address from the end of msg.data
            assembly {
                ret := shr(96,calldataload(sub(calldatasize(),20)))
            }
        } else {
            ret = msg.sender;
        }
    }

    function _msgData() internal override virtual view returns (bytes calldata ret) {
        if (msg.data.length >= 20 && isTrustedForwarder(msg.sender)) {
            return msg.data[0:msg.data.length-20];
        } else {
            return msg.data;
        }
    }

}