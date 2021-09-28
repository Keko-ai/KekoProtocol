// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IForwarderRegistry.sol";

contract ForwarderRegistry is IForwarderRegistry{

    mapping(address => bool) internal _registeredForwarders;

    function _setRegisteredForwarder(address forwarder, bool status) internal{
        _registeredForwarders[forwarder] = status;
        emit ForwarderRegistryUpdate(forwarder,status);
    }

    function isRegistedForwarder(address forwarder) external view override returns(bool){
        return _registeredForwarders[forwarder];
    }
    
}