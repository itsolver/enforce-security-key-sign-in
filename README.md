# Enforce Security Key Sign-in

## Important Requirement
Before using this script, you must have enabled the FIDO2 Security Key method within Entra (formerly Azure AD) and added a security key to your account. For guidance on this, refer to Microsoft's documentation: [User registration and management of FIDO2 Security Keys](https://learn.microsoft.com/en-us/entra/identity/authentication/howto-authentication-passwordless-security-key#user-registration-and-management-of-fido2-security-keys).

## Description
This CMD script enforces the use of Security Keys for signing into Windows computers by disabling Windows Hello PIN and other sign-in methods. Ideal for environments requiring enhanced security through physical security keys.

## Prerequisites
- Administrative privileges on the Windows computer.
- Basic understanding of running scripts and batch files on Windows.

## How to Use

### Step 1: Download the Script
1. Download the repository as a ZIP file by clicking on `Code` and then `Download ZIP`.
2. Extract the ZIP file to a known location on your computer.

### Step 2: Run the Script
1. Navigate to the extracted folder and double click on the `enforce-security-key-sign-in.cmd` file.
2. If SmartScreen warning: click More info > run anyway.
3. If UAC prompt: allow changes by signing in as admin (if current user doesn't have admin).
5. Wait for the Command Prompt window to complete the script execution.

### Step 3: Lock computer to confirm only Security Key is sign in option
- Changes take effect instantly.

## Warning
- Modifying system settings can have significant effects. Understand the implications of disabling certain sign-in options.
- Test the script in a non-production environment first.
- Ensure you have a backup or recovery plan.

# Credit and References
Thanks to Jonas Markström for sharing your knowledge.

- [Three ways of enabling security key sign-in on Windows 10 & Windows 11](https://swjm.blog/three-ways-of-enabling-security-key-sign-in-on-windows-10-windows-11-5c93a85727cc)
- [https://swjm.blog/fido2-security-key-sign-in-with-azure-ad-in-5-simple-steps-44ae0a71dc34](https://swjm.blog/fido2-security-key-sign-in-with-azure-ad-in-5-simple-steps-44ae0a71dc34)
