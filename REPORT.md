# Findings

## A malicious actor can directly call the `delegatecallContract()`, compromising the entire protocol

**Severity**: High

Context: [`Implementation.sol#L17-L21`](https://github.com/martinivv/spearbit-task/blob/develop/src/Implementation.sol#L17-L21)

A malicious actor can call the `delegatecallContract()`, delegating the execution to a malicious contract by passing the address of the malicious contract and the desired method from it as arguments. Then, the malicious contract can destruct the `Implementation` contract, effectively freezing all calls and thereby disrupting the entire protocol.

**Recommendation**

1. Implementing `onlyDelegateCall` modifier, will prevent accessing the `Implementation`'s contract state.
2. _BONUS._ The implementation contract can be converted into a library; makes it stateless, unable to hold any ether.
