// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IForwarderRegistry{

    function isRegistedForwarder(address forwarder) external view returns (bool);

    event ForwarderRegistryUpdate(address indexed _forwarder, bool indexed _status);

}