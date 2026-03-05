#!/bin/bash

echo "=========================================
      SERVER PERFORMANCE REPORT
=========================================
Generated on: $(date)
Hostname: $(hostname)
========================================="
echo ""

echo "---- CPU Usage ----"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
echo ""

echo "---- Memory Usage ----"
free -m | awk 'NR==2{
    printf "Total: %sMB\nUsed: %sMB\nFree: %sMB\nUsage: %.2f%%\n",
    $2,$3,$4,$3*100/$2 }'
echo ""

echo "---- Disk Usage ----"
df -h / | awk 'NR==2{
    printf "Total: %s\nUsed: %s\nFree: %s\nUsage: %s\n",
    $2,$3,$4,$5 }'
echo ""

echo "---- Top 5 Processes by CPU ----"
ps aux --sort=-%cpu | head -n 6
echo ""

echo "---- Top 5 Processes by Memory ----"
ps aux --sort=-%mem | head -n 6
echo ""

echo "---- System Info ----"
echo "Uptime:"
uptime
echo ""

echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo ""

echo "OS Version:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo ""

echo "Logged in users:"
who
echo ""

echo "========================================="
echo "End of Report"
echo "========================================="
