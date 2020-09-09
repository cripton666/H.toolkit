#!/bin/bash

echo "Instalando dsniff(arpspoof)"
sudo apt-get install dsniff
sudo apt-get install arpspoof
echo "1" > /proc/sys/net/ipv4/ip_forward iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-ports 8080
sudo "Instalando sqlmap"
sudo apt-get install sqlmap



