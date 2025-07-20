# 📊 For\_Web\_Data\_Collection - School Project 2132132

A powerful, automated website data collection script designed to streamline reconnaissance and gather comprehensive information about websites. This project is built for educational purposes to demonstrate practical web reconnaissance techniques.

---

## 🎯 Project Overview

This Bash script performs automated reconnaissance on a given website using **30+ industry-standard tools**. It collects data such as:

* Website technology stack
* DNS records
* Open ports and services
* SSL/TLS security details
* Subdomains
* Public information leaks
* Directory brute-force findings
* Archived links and much more

All findings are compiled into a well-organised report in a .txt file.

---

## ⚙️ How to Use

### 1. Clone the Project

```bash
git clone https://github.com/schoolproject2132132/For_Web_data_collection.git
cd For_Web_data_collection
```

### 2. Give Permission and Run

```bash
chmod +x website-audit.sh
sudo ./website-audit.sh
```

> ⚠️ **Important:** Run the script with `sudo` to allow installation of any missing tools.

### 3. Provide Input

* Enter the **target website domain** (without `https://`).
* The script will:

  * Resolve the domain IP
  * Install missing tools
  * Perform deep analysis
  * Save the output in a dated text file
  * Offer to open the report immediately

---

## 📂 Project Structure

| File               | Description                               |
| ------------------ | ----------------------------------------- |
| `website-audit.sh` | Main script for automated data collection |
| `LICENSE`          | MIT license for open use                  |
| `README.md`        | Documentation and instructions            |

---

## 🛠️ Tools Included

Includes automatic use of:
`whatweb`, `nmap`, `whois`, `dig`, `dnsenum`, `theharvester`, `wafw00f`, `sslscan`, `nikto`, `sublist3r`, `amass`, `dirb`, `waybackurls`, `httpx`, `massdns`, `asnlookup`, `shcheck`, `fierce`, `dnsmap`, `metagooofil`, `gitrob`, `aquatone`, `feroxbuster`, `ffuf`, `recon-ng`, `ctfr`, `github-dorks`, `nuclei`, and others.

---

## 📝 License

This project is licensed under the MIT License.
See the [LICENSE](./LICENSE) file for full details.

---

## 📌 Disclaimer

This tool is strictly for **educational purposes** within the scope of **School Project 2132132**.
Do **not** use this tool against unauthorized targets. Always respect applicable cyber laws.
