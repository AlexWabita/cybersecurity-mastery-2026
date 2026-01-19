# Linux File System - Security Perspective

## Critical Directories for Penetration Testing

### /etc - Configuration Files
- Contains: system configs, user passwords (/etc/shadow), network settings
- Security relevance: Often contains hardcoded credentials, API keys
- Common targets: /etc/passwd, /etc/shadow, /etc/hosts, /etc/ssh/sshd_config

### /var/log - System Logs
- Contains: application and system logs
- Security relevance: Shows admin activity, can reveal credentials in cleartext
- Common targets: /var/log/auth.log, /var/log/apache2/access.log

### /tmp - Temporary Files
- Contains: world-writable temp files
- Security relevance: Upload point for exploits, often not monitored
- Usage: Place to drop malware during post-exploitation

### /home - User Directories
- Contains: user personal files
- Security relevance: SSH keys, bash history, personal credentials
- Common targets: ~/.ssh/id_rsa, ~/.bash_history, ~/.config/

### /root - Root's Home
- Contains: administrator's personal files
- Security relevance: High-value target after privilege escalation
- Access: Requires root privileges

## Quick Navigation Commands
- pwd → Print working directory
- cd → Change directory
- ls -la → List all files with permissions
- find / -name "*.conf" → Find all config files
