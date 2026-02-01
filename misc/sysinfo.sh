#!/bin/bash

# ==========================================
# System Info Script
# Shows quick system overview: 
# - Linux version
# - Host model
# - CPU details
# - Memory usage
# - Disks info (model + free/used space)
# ==========================================

# Linux version
echo "=== Linux Version ==="
uname -a
echo

# Host model
echo "=== Host Model ==="
if command -v dmidecode &> /dev/null; then
    sudo dmidecode -s system-product-name
else
    echo "dmidecode not available (install with: sudo apt install dmidecode)"
fi
echo

# CPU info
echo "=== CPU Info ==="
lscpu | grep -E 'Model name|Socket|Thread|CPU\(s\)'
echo

# Memory usage
echo "=== Memory (RAM) ==="
free -h
echo

# Disk info
echo "=== Disks ==="
lsblk -o NAME,MODEL,SIZE,TYPE | grep -E "disk"
echo

# Disk usage (space free/used)
echo "=== Disk Usage ==="
df -h -x tmpfs -x devtmpfs
echo
echo "======================================================"
