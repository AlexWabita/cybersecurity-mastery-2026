# Linux File Permissions - Security Perspective

## Permission Notation Breakdown

Format: `drwxrwxrwx`

Example: `-rwxr-xr-x 1 root root 1265648 /bin/bash`

### Permission String: `-rwxr-xr-x`
```
-  rwx  r-x  r-x
│   │    │    │
│   │    │    └─ Others (everyone else)
│   │    └────── Group owner
│   └─────────── File owner
└─────────────── File type (- = file, d = directory, l = link)
```

### Permission Meanings
- `r` (read) = 4
- `w` (write) = 2  
- `x` (execute) = 1
- `-` (no permission) = 0

**Numeric notation**: `rwxr-xr-x` = `755` (7=rwx, 5=r-x, 5=r-x)

---

## SUID Binaries - The Privilege Escalation Vector

### What is SUID?
**SUID (Set User ID)** - When set, the file executes with the owner's privileges, not the executor's.

**Notation**: `s` replaces `x` in owner permissions
```
-rwsr-xr-x  ← SUID bit set (note the 's')
   ↑
```

### Why SUID Exists
Example: `/usr/bin/passwd`
- Owned by root
- Has SUID bit set
- Regular users can run it
- When executed, it runs AS ROOT
- This allows users to modify /etc/shadow (root-only file)

### Security Implications

**Legitimate Use:**
```
/usr/bin/passwd  → User changes their password (needs root to write /etc/shadow)
/usr/bin/sudo    → Controlled privilege elevation
/usr/bin/ping    → Needs raw socket access (root privilege)
```

**Exploitation Risk:**
If a vulnerable SUID binary exists:
- Hacker can execute code as root
- Read sensitive files
- Write to protected locations
- Complete system compromise

### Finding SUID Binaries

Command:
```bash
find / -perm -4000 2>/dev/null
```

Explanation:
- `/` = Search entire filesystem
- `-perm -4000` = Find SUID files (octal 4000 = SUID bit)
- `2>/dev/null` = Suppress permission errors

### SUID Binaries Found on My System
```
/usr/bin/passwd
/usr/bin/sudo
/usr/bin/su
/usr/sbin/exim4  ← Mail server (known vulnerabilities!)
/usr/bin/ntfs-3g
... (see full list in reconnaissance)
```

### Privilege Escalation via SUID

**Attack Vector:**
1. Compromise low-privilege account
2. Enumerate SUID binaries
3. Check for vulnerable/misconfigured binaries
4. Exploit to gain root shell

**Resources:**
- GTFOBins (https://gtfobins.github.io/) - SUID exploitation database
- Check binary versions against CVE databases

### Security Best Practices

**As Defender:**
- Regularly audit SUID binaries
- Remove SUID from unnecessary binaries
- Keep system binaries updated

**As Pentester:**
- Always enumerate SUID in post-exploitation
- Check GTFOBins for exploitation methods
- Test for vulnerable versions

---

## Permission Security Examples

### Dangerous Permissions
```bash
-rwxrwxrwx  # World-writable! Anyone can modify
-rwsr-sr-x  # SUID + SGID on unusual binary = investigate
```

### Secure Permissions
```bash
-rwxr-xr-x  # Owner can modify, others can only read/execute
-rw-r--r--  # Config files - owner writes, others read
-rw-------  # Private files - only owner access
```

---

**Created**: January 2026  
**Author**: Alex Wabita
