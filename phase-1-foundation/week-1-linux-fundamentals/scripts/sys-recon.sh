#!/bin/bash
# System Reconnaissance Script
# Purpose: Gather basic system information for security assessment
# Author: Alex Wabita
# Date: January 2026

echo "=========================================="
echo "    SYSTEM RECONNAISSANCE REPORT"
echo "=========================================="
echo ""

echo "[+] Current User:"
whoami
echo ""

echo "[+] User ID and Groups:"
id
echo ""

echo "[+] Operating System:"
cat /etc/os-release | grep PRETTY_NAME
echo ""

echo "[+] Kernel Version:"
uname -r
echo ""

echo "[+] Hostname:"
hostname
echo ""

echo "[+] Current Directory:"
pwd
echo ""

echo "[+] Network Interfaces:"
ip addr show | grep "inet " | awk '{print $2}'
echo ""

echo "[+] Active Network Connections:"
ss -tuln | head -10
echo ""

echo "[+] Running Processes (top 10 by CPU):"
ps aux --sort=-%cpu | head -11
echo ""

echo "=========================================="
echo "    RECONNAISSANCE COMPLETE"
echo "=========================================="
