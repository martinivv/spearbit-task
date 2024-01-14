# Findings

## A malicious actor can directly call the `delegatecallContract()`, compromising the entire protocol

**Severity**: High

Context: [`Implementation.sol#L17-L21`](github.com/permalink)

A malicious actor can call the `delegatecallContract()`, delegating the execution to a malicious contract by passing the address of the malicious contract and the desired method from it as arguments. Then, the malicious contract can destruct the `Implementation` contract, effectively freezing all calls and thereby disrupting the entire protocol.

**Recommendation**

1. Implementing `onlyDelegateCall` modifier, will prevent accessing the `Implementation`'s contract state.
2. _BONUS._ The implementation contract can be converted into a library; makes it stateless, unable to hold any ether.

## No zero-checks

**Severity**: Informational

Context: [`Proxy.sol#L18-L19`](github.com/permalink)

Missing zero-checks before initializing variables.

**Recommendation**: Consider checking for zero passed arguments; apply accurately chosen deployment process.
