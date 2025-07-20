#!/bin/bash

OUTFILE="website-audit-$(date +%Y%m%d-%H%M%S).txt"
TOOLS=( \
  "whatweb" "nmap" "whois" "dig" "dnsenum" "theharvester" "wafw00f" "sslscan" "nikto" \
  "sublist3r" "dirb" "curl" "waybackurls" "httpx" "amass" "massdns" "asnlookup" \
  "shcheck" "fierce" "dnsmap" "metagooofil" "gitrob" "aquatone" "feroxbuster" "ffuf" \
  "recon-ng" "ctfr" "github-dorks" "nuclei" \
)

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[!] Error: Please run as root.${NC}"
    exit 1
fi

function check_tools() {
    echo -e "${GREEN}[+] Checking and installing tools...${NC}"
    for tool in "${TOOLS[@]}"; do
        if ! command -v $tool &>/dev/null; then
            echo -e "${YELLOW}[-] $tool missing, installing...${NC}"
            apt-get install -y $tool &>/dev/null || echo -e "${RED}[!] Could not install $tool.${NC}"
        else
            echo -e "${GREEN}[✔] $tool found.${NC}"
        fi
    done
}

clear
check_tools

echo -e "\n${GREEN}[*] Target domain (without https):${NC}"
read TARGET

IP=$(dig +short $TARGET | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" | head -n1)
[[ -z "$IP" ]] && echo -e "${RED}[!] Cannot resolve IP.${NC}" && exit 1

echo -e "${GREEN}[+] Target IP: $IP${NC}"
echo -e "${GREEN}[+] Starting massive reconnaissance on $TARGET...${NC}\n"

{
    echo "##### Recon Report for $TARGET - $(date) #####"
    echo "IP Address: $IP"

    echo "\n== WhatWeb =="
    whatweb $TARGET

    echo "\n== Nmap Top Ports =="
    nmap -sS -sV -Pn -T4 $TARGET

    echo "\n== Whois =="
    whois $TARGET

    echo "\n== Dig DNS Info =="
    dig any $TARGET +noall +answer

    echo "\n== DNSENUM =="
    dnsenum $TARGET

    echo "\n== TheHarvester =="
    theharvester -d $TARGET -b all -l 100

    echo "\n== WAFW00F =="
    wafw00f http://$TARGET

    echo "\n== SSLScan =="
    sslscan $TARGET

    echo "\n== Nikto =="
    nikto -host $TARGET

    echo "\n== Sublist3r =="
    sublist3r -d $TARGET

    echo "\n== Amass Passive =="
    amass enum -passive -d $TARGET

    echo "\n== Dirb Directory Brute =="
    dirb http://$TARGET

    echo "\n== Curl Headers =="
    curl -I http://$TARGET

    echo "\n== Waybackurls =="
    [[ $(command -v waybackurls) ]] && echo "$TARGET" | waybackurls || echo "[!] waybackurls not installed."

    echo "\n== Httpx =="
    [[ $(command -v httpx) ]] && echo "$TARGET" | httpx -title -tech-detect || echo "[!] httpx not installed."

    echo "\n== Massdns =="
    [[ $(command -v massdns) ]] && echo "$TARGET" | massdns || echo "[!] massdns not installed."

    echo "\n== ASN Lookup =="
    [[ $(command -v asnlookup) ]] && asnlookup $TARGET || echo "[!] asnlookup not installed."

    echo "\n== SHcheck =="
    [[ $(command -v shcheck) ]] && shcheck http://$TARGET || echo "[!] shcheck not installed."

    echo "\n== Fierce =="
    [[ $(command -v fierce) ]] && fierce --domain $TARGET || echo "[!] fierce not installed."

    echo "\n== DNSMap =="
    [[ $(command -v dnsmap) ]] && dnsmap $TARGET || echo "[!] dnsmap not installed."

    echo "\n== MetaGooFil =="
    [[ $(command -v metagooofil) ]] && metagooofil -d $TARGET || echo "[!] metagooofil not installed."

    echo "\n== GitRob =="
    [[ $(command -v gitrob) ]] && gitrob $TARGET || echo "[!] gitrob not installed."

    echo "\n== Aquatone =="
    [[ $(command -v aquatone) ]] && echo "$TARGET" | aquatone || echo "[!] aquatone not installed."

    echo "\n== Feroxbuster =="
    [[ $(command -v feroxbuster) ]] && feroxbuster -u http://$TARGET || echo "[!] feroxbuster not installed."

    echo "\n== FFUF =="
    [[ $(command -v ffuf) ]] && ffuf -u http://$TARGET/FUZZ -w /usr/share/wordlists/dirb/common.txt || echo "[!] ffuf not installed."

    echo "\n== Recon-NG =="
    [[ $(command -v recon-ng) ]] && recon-ng -r $TARGET || echo "[!] recon-ng not installed."

    echo "\n== CTFR =="
    [[ $(command -v ctfr) ]] && ctfr -d $TARGET || echo "[!] ctfr not installed."

    echo "\n== GitHub Dorks =="
    [[ $(command -v github-dorks) ]] && github-dorks -d $TARGET || echo "[!] github-dorks not installed."

    echo "\n== Nuclei =="
    [[ $(command -v nuclei) ]] && nuclei -u http://$TARGET || echo "[!] nuclei not installed."

    echo "##### END OF REPORT #####"
} | tee "$OUTFILE"

echo -e "\n${GREEN}[+] Recon complete. Report saved at $OUTFILE.${NC}"
echo -e "${GREEN}[?] Open report in nano? (y/n):${NC}"
read VIEW
[[ $VIEW =~ ^[Yy]$ ]] && nano "$OUTFILE"

##############################################################
# MIT License
# Copyright (c) 2025
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
##############################################################
