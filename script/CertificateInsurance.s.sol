// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CertificateInsurance} from "../src/CertificateInsurance.sol";

contract CounterScript is Script {
    CertificateInsurance public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new CertificateInsurance();

        vm.stopBroadcast();
    }
}
