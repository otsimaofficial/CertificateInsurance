// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/CertificateInsurance.sol";

contract CertificateInsuranceTest is Test {
    CertificateInsurance cert;
    address owner;
    address admin;
    address user;
    bytes32 certHash;

    function setUp() public {
        owner = address(this); 
        admin = vm.addr(1);
        user = vm.addr(2);
        certHash = keccak256("CERT123");

        cert = new CertificateInsurance();
    }

    function testAddAdminByOwner() public {
        cert.addAdmin(admin);
        assertTrue(cert.isAdmin(admin));
    }

    function testRegisterCertificateByAdmin() public {
        cert.addAdmin(admin);
        vm.prank(admin);
        cert.registerCertificate(certHash, "Emmanuel", "Blockchain", "TechUni", user);

        (, , , , CertificateInsurance.CertStatus status) = cert.certificates(certHash);
        assertEq(uint(status), 0); // Unverified
    }

    function testVerifyCertificateByAdmin() public {
        cert.addAdmin(admin);
        vm.prank(admin);
        cert.registerCertificate(certHash, "Emmanuel", "Solidity", "ChainSchool", user);

        vm.prank(admin);
        cert.verifyCertificate(certHash);

        (, , , , CertificateInsurance.CertStatus status) = cert.certificates(certHash);
        assertEq(uint(status), 1); // Verified
    }

    function testPublicCheckAuthenticity() public {
        cert.addAdmin(admin);
        vm.prank(admin);
        cert.registerCertificate(certHash, "Emmanuel", "Web3", "OpenUni", user);
        vm.prank(admin);
        cert.verifyCertificate(certHash);

        (bool verified, , , ) = cert.isCertificateAuthentic(certHash);
        assertTrue(verified);
    }

    function testOnlyAdminCanRegister() public {
        vm.expectRevert();
        vm.prank(user);
        cert.registerCertificate(certHash, "NotAdmin", "HackCourse", "BadUni", user);
    }

    function testCannotAddZeroAddressAsAdmin() public {
        vm.expectRevert(CertificateInsurance.InvalidAddress.selector);
        cert.addAdmin(address(0));
    }
}
