# Security Scripts Collection

Custom tools and automation scripts for security assessments and system reconnaissance.

---

## sys-recon.sh

**Purpose**: Automated system information gathering for initial reconnaissance after gaining access to a system.

**Usage**:
```bash
chmod +x sys-recon.sh
./sys-recon.sh
```

**What it collects**:
- Current user identity and group memberships
- User ID (UID) and group ID (GID)
- Operating system and version
- Linux kernel version
- System hostname
- Current working directory
- Network interfaces and IP addresses
- Active network connections (listening ports)
- Running processes sorted by CPU usage

**Use cases**:
- Post-exploitation enumeration on compromised systems
- Initial foothold assessment during CTFs
- Understanding system environment and privilege level
- Identifying potential privilege escalation paths
- Practice on labs (HackTheBox, TryHackMe, personal VMs)

**Expected Output Example**:
```
==========================================
    SYSTEM RECONNAISSANCE REPORT
==========================================

[+] Current User:
scorpion

[+] User ID and Groups:
uid=1001(scorpion) gid=1001(scorpion) groups=1001(scorpion),27(sudo)...

[+] Operating System:
PRETTY_NAME="Parrot Security 6.4 (lorikeet)"

[+] Network Interfaces:
127.0.0.1/8
10.0.2.15/24

[+] Active Network Connections:
tcp LISTEN 0.0.0.0:22 (SSH potentially accessible)
...
```

**Key Information for Privilege Escalation**:
- If user is in `sudo` group → Can potentially run commands as root
- If user is in `docker` group → Possible container escape to root
- Open ports on 0.0.0.0 → Services exploitable from network
- Processes running as root → High-value targets

**Security Notes**:
- Output may contain sensitive IP addresses - sanitize before sharing
- Use only on authorized systems
- Never run on production systems without permission

**Author**: Alex Wabita  
**Created**: January 2026  
**Last Updated**: January 2026

---

## Future Scripts
(This section will grow as more tools are added)

---

## Usage Guidelines

All scripts in this collection are for:
- ✅ Educational purposes and skill development
- ✅ Authorized penetration testing with written permission
- ✅ Personal systems and controlled lab environments
- ✅ Intentionally vulnerable VMs (HackTheBox, TryHackMe, VulnHub)

**❌ Never use on systems without explicit authorization.**

## Contributing to This Collection

As I build more tools, I'll document:
- Purpose and use case
- Expected output
- Security implications
- Ethical usage guidelines
