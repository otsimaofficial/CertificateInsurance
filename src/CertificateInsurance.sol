// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CertificateInsurance {
    address public owner;
    mapping(address => bool) public isAdmin;

    constructor() {
        owner = msg.sender;
    }

    enum CertStatus {
        Unverified,
        Verified
    }

    struct Certificate {
        string name;
        string course;
        string institution;
        address holder;
        CertStatus status;
    }

    mapping(bytes32 => Certificate) public certificates;

    // Events
    event AdminAdded(address admin);
    event CertificateRegistered(bytes32 certHash, address indexed by);
    event CertificateVerified(bytes32 certHash, address indexed by);

    // Custom Errors
    error NotOwner();
    error NotAdminOrOwner();
    error InvalidAddress();
    error AlreadyExists();
    error NotFound();

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier onlyAdminOrOwner() {
        if (!(isAdmin[msg.sender] || msg.sender == owner)) revert NotAdminOrOwner();
        _;
    }

    // Admin Management
    function addAdmin(address _admin) external onlyOwner {
        if (_admin == address(0)) revert InvalidAddress();
        isAdmin[_admin] = true;
        emit AdminAdded(_admin);
    }

    // Register certificate
    function registerCertificate(
        bytes32 _certHash,
        string memory _name,
        string memory _course,
        string memory _institution,
        address _holder
    ) external onlyAdminOrOwner {
        if (_holder == address(0)) revert InvalidAddress();
        if (certificates[_certHash].holder != address(0)) revert AlreadyExists();

        certificates[_certHash] = Certificate({
            name: _name,
            course: _course,
            institution: _institution,
            holder: _holder,
            status: CertStatus.Unverified
        });

        emit CertificateRegistered(_certHash, msg.sender);
    }

    // Verify certificate
    function verifyCertificate(bytes32 _certHash) external onlyAdminOrOwner {
        if (certificates[_certHash].holder == address(0)) revert NotFound();

        certificates[_certHash].status = CertStatus.Verified;
        emit CertificateVerified(_certHash, msg.sender);
    }

    // Public check
    function isCertificateAuthentic(bytes32 _certHash)
        external
        view
        returns (bool, string memory, string memory, string memory)
    {
        Certificate memory cert = certificates[_certHash];
        if (cert.holder == address(0)) revert NotFound();
        return (cert.status == CertStatus.Verified, cert.name, cert.course, cert.institution);
    }
}
