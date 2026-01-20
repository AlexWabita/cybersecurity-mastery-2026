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


---
---



---

## suid-finder.sh

**Purpose**: Enumerate and categorize SUID binaries for privilege escalation reconnaissance during penetration testing.

**Usage**:
```bash
chmod +x suid-finder.sh
./suid-finder.sh
```

**What it does**:
- Searches entire filesystem for SUID binaries
- Categorizes binaries as STANDARD, INVESTIGATE, or SUSPICIOUS
- Flags binaries in high-risk locations (/tmp, /home, /var/tmp)
- Displays ownership and permissions for each binary
- Provides GTFOBins lookup recommendations

**Use cases**:
- Post-exploitation privilege escalation enumeration
- System security auditing
- Identifying misconfigured SUID binaries
- CTF challenges requiring privilege escalation
- Security baseline documentation

**Expected Output Example**:
```
==========================================
    SUID BINARY ENUMERATION
==========================================

[+] Total SUID binaries found: 23

[STANDARD] /usr/bin/passwd
[STANDARD] /usr/bin/sudo
...

[INVESTIGATE] /usr/sbin/exim4
  └─ Permissions: -rwsr-xr-x root root

[SUSPICIOUS] /tmp/suspicious-script.sh
  └─ Location: High-risk directory!
  └─ Permissions: -rwsr-xr-x root root
```

**Key Findings to Investigate**:
- Binaries in `/tmp`, `/home`, `/var/tmp` (unusual locations)
- Third-party applications with SUID (exim, ntfs-3g, pppd)
- Binaries with both SUID and SGID bits set
- Custom scripts with SUID (major red flag)

**Privilege Escalation Workflow**:
1. Run this script on compromised system
2. Focus on INVESTIGATE and SUSPICIOUS binaries
3. Check GTFOBins for exploitation methods
4. Verify binary versions against CVE databases
5. Test for command injection or path manipulation
6. Attempt privilege escalation to root

**Defense Recommendations**:
- Remove SUID from unnecessary binaries: `chmod u-s /path/to/binary`
- Regularly audit SUID binaries and maintain baseline
- Monitor for new SUID binaries (sign of compromise)
- Keep system binaries updated to patch vulnerabilities

**Author**: Alex Wabita  
**Created**: January 2026  
**Last Updated**: January 2026
