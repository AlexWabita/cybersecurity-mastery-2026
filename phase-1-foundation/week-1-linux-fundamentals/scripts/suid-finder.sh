#!/bin/bash
# SUID Binary Enumeration Script
# Purpose: Find and categorize SUID binaries for privilege escalation reconnaissance
# Author: Alex Wabita
# Date: January 2026

echo "=========================================="
echo "    SUID BINARY ENUMERATION"
echo "=========================================="
echo ""
echo "[*] Searching for SUID binaries (this may take a moment)..."
echo ""

# Find all SUID binaries and store in variable
suid_binaries=$(find / -perm -4000 -type f 2>/dev/null)

# Count total SUID binaries found
total_count=$(echo "$suid_binaries" | wc -l)

echo "[+] Total SUID binaries found: $total_count"
echo ""

# Define common/expected SUID binaries (legitimate system binaries)
common_suid=(
    "/usr/bin/passwd"
    "/usr/bin/sudo"
    "/usr/bin/su"
    "/usr/bin/chfn"
    "/usr/bin/chsh"
    "/usr/bin/gpasswd"
    "/usr/bin/newgrp"
    "/usr/bin/mount"
    "/usr/bin/umount"
    "/usr/bin/fusermount"
    "/usr/bin/fusermount3"
    "/usr/bin/pkexec"
    "/usr/bin/newgidmap"
    "/usr/bin/newuidmap"
)

echo "=========================================="
echo "    STANDARD SUID BINARIES"
echo "=========================================="
echo ""

# Check each found binary against common list
for binary in $suid_binaries; do
    is_common=false
    for common in "${common_suid[@]}"; do
        if [[ "$binary" == "$common" ]]; then
            is_common=true
            break
        fi
    done
    
    if [ "$is_common" = true ]; then
        echo "[STANDARD] $binary"
    fi
done

echo ""
echo "=========================================="
echo "    UNUSUAL/INTERESTING SUID BINARIES"
echo "=========================================="
echo ""

# Flag potentially interesting binaries
interesting_found=false

for binary in $suid_binaries; do
    is_common=false
    for common in "${common_suid[@]}"; do
        if [[ "$binary" == "$common" ]]; then
            is_common=true
            break
        fi
    done
    
    if [ "$is_common" = false ]; then
        interesting_found=true
        
        # Get owner and permissions
        perms=$(ls -la "$binary" 2>/dev/null | awk '{print $1, $3, $4}')
        
        # Check if in unusual location
        if [[ "$binary" == /tmp/* ]] || [[ "$binary" == /home/* ]] || [[ "$binary" == /var/tmp/* ]]; then
            echo "[SUSPICIOUS] $binary"
            echo "  └─ Location: High-risk directory!"
            echo "  └─ Permissions: $perms"
        else
            echo "[INVESTIGATE] $binary"
            echo "  └─ Permissions: $perms"
        fi
        echo ""
    fi
done

if [ "$interesting_found" = false ]; then
    echo "[+] No unusual SUID binaries detected."
    echo ""
fi

echo "=========================================="
echo "    GTFOBINS CHECK RECOMMENDATIONS"
echo "=========================================="
echo ""
echo "Check these binaries on GTFOBins (https://gtfobins.github.io/):"
echo ""

# List unique binary names (without path) for GTFOBins lookup
echo "$suid_binaries" | xargs -n 1 basename | sort -u | grep -v "^$" | head -20

echo ""
echo "=========================================="
echo "    ENUMERATION COMPLETE"
echo "=========================================="
echo ""
echo "[*] Tip: Focus on binaries in unusual locations (/tmp, /home, /opt)"
echo "[*] Tip: Check binary versions for known CVEs"
echo "[*] Tip: Test unusual binaries for command injection vulnerabilities"
