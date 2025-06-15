# 📜 CertificateInsurance Smart Contract

**CertificateInsurance** is a simple yet secure Ethereum-based smart contract for certificate registration and verification. Designed for educational and demo purposes, it enables trusted organizations to upload, verify, and authenticate certificates transparently on-chain.

---

## ✨ Features

- ✅ **Owner/Administrator Roles**:  
  - Contract owner can add admins.  
  - Both owner and admins can register and verify certificates.

- 🔒 **Security Measures**:  
  - Rejects `address(0)` entries.  
  - Access controlled using `modifiers`.  
  - Uses custom `errors` for gas optimization.  
  - Prevents duplicate certificate registration.

- 📑 **Certificate Data**:  
  - Each certificate includes an ID, holder's name, course, issue date, and verification status.

- 🌐 **Public Verification**:  
  - Anyone (organization/public) can verify the authenticity of a certificate.

---

## ⚙️ Functions

### Admin Controls
- `addAdmin(address _admin)` — Owner can assign admin roles.
- `isAdmin(address)` — View if an address is an admin.

### Certificate Management
- `registerCertificate(...)` — Admins can register new certificates.
- `verifyCertificate(uint id)` — Admins verify existing certificates.
- `getCertificate(uint id)` — Anyone can view the full certificate details.
- `isCertificateVerified(uint id)` — Anyone can check if a certificate is verified.

---

## 🔐 Modifiers & Access Control

- `onlyOwner` — Restricts access to the contract owner.
- `onlyAdminOrOwner` — Allows only owner or assigned admins to run sensitive functions.

---

## 🧪 Testing

Basic test coverage includes:
- ✅ Admin addition
- ✅ Certificate registration & verification
- ✅ Public verification access
- ✅ Rejection of invalid or duplicate certificates
- ✅ Role-restricted actions

---

## 🛠 Tech Stack

- **Solidity**: ^0.8.24
- **Foundry**: For compiling and testing
- **Ethereum Virtual Machine (EVM)**

---

## 🧑‍💻 Developer Notes

This contract is kept intentionally under **120 lines** for simplicity. It’s ideal for student learning or proof-of-concept (POC) use.

---

## 📄 License

MIT License — free to use and modify, with attribution.

---

## 🤝 Contributing

This contract is meant to grow with input. If you’d like to contribute or improve security checks or add NFT issuance for verified certs, feel free to fork and PR!

---

## 🧠 Inspiration

Inspired by the need to protect and verify academic and professional credentials in a decentralized and tamper-proof way.

---

