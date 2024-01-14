// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract ImplementationV2 {
    address private immutable self = address(this);

    error NotDelegated();
    error MessageFailed();

    modifier onlyDelegateCall() {
        if (address(this) == self) revert NotDelegated();
        _;
    }

    function callContract(address a_, bytes calldata calldata_)
        external
        payable
        onlyDelegateCall
        returns (bytes memory)
    {
        (bool ok, bytes memory out) = a_.call{value: msg.value}(calldata_);
        if (!ok) revert MessageFailed();
        return out;
    }

    function delegatecallContract(address a_, bytes calldata calldata_)
        external
        payable
        onlyDelegateCall
        returns (bytes memory)
    {
        (bool ok, bytes memory out) = a_.delegatecall(calldata_);
        if (!ok) revert MessageFailed();
        return out;
    }
}
