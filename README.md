# 🛡️ vuln-detection-platform (Candy 2.0)

**Candy 2.0** is a centralized vulnerability detection and **Attack Surface Management (ASM)** platform designed to map, analyze, and prioritize an organization’s entire internet-exposed footprint.

It combines automated reconnaissance, intelligent scoring, and a web-based control plane — all packaged in a containerized deployment.

> Built for security researchers, bug bounty hunters, and blue teams who want **signal over noise**.

---

## 🚀 What Candy 2.0 Does

Candy scans public-facing infrastructure and answers one core question:

> **“If I were an attacker, which assets should I go after first?”**

It discovers domains, IPs, services, applications, and metadata, then **scores and prioritizes** them from *most attractive* to *least attractive* attack surfaces.

---

## ✨ Key Features

### 🔍 Comprehensive Recon
- Subdomain enumeration via **Subfinder, Assetfinder, CHAOS, crt.sh**
- DNS resolution and validation using **dnsx**
- Port scanning via **naabu**

### 🌐 Deep Web Analysis
- HTTP fingerprinting & metadata collection (**httpx**)
- Login surface detection (forms, auth flows, headers, cookies)
- Screenshot capture for live applications
- Recursive crawling using **Katana**

### 📊 Intelligent Risk Scoring
- Composite score (0–100) across:
  - **Exposure** (ports, services, attack surface)
  - **Hygiene** (headers, TLS, DNS, email auth)
  - **Sensitivity** (logins, management ports, internal apps)
- Transparent scoring explanations per asset

### 📑 Professional Reporting
- Self-contained HTML report (no server required)
- Dark / light theme
- CSV & JSON exports
- Screenshot embedding
- Historical scan tracking

### 🧠 Control Plane
- Web UI for scan creation, queueing, and scheduling
- Parallel execution support
- Live progress tracking (17-step pipeline)
- Cancel / rescan / modify jobs
- Persistent scan history

---

## ⏱️ Approximate Runtime

**Pipeline:** 17 stages  
**Environment:** Docker container on ~2 vCPU / 4–8 GB RAM VM

| Discovered Subdomains | Typical Runtime | Notes |
|----------------------|-----------------|------|
| ≤ 100 | 20–40 min | Port scans + screenshots dominate |
| 100–999 | 45–120 min | Crawling & TLS checks scale linearly |
| 1k–9k | 3–6 hours | Rate limits & I/O become bottlenecks |
| 10k+ | 8–18 hours | Large-scale scanning + throttling |

> Runtime varies heavily based on upstream rate limits, timeouts, and crawl depth.

---

## 🧮 Risk Scoring Model

Scores are capped across three buckets:

- **Exposure (≤45)** – open ports, services, crawl depth
- **Hygiene (≤35)** – TLS, headers, DNS, email auth
- **Sensitivity (≤20)** – logins, management & DB ports

Final score = capped sum (**max 100**)

This allows rapid prioritization of **high-impact targets** first.

---
## 🐳 Installation & Usage

```bash
# Give execute permissions
chmod +x candy.sh entrypoint.sh

# Build Docker image
docker build -t candys-crew:latest .

# Run on Linux (host networking)
docker run --rm --network host --privileged --cap-add=NET_RAW candys-crew:latest

# Run on macOS / Windows (Docker Desktop)
docker run --rm -p 8787:8787 --privileged --cap-add=NET_RAW candys-crew:latest

# (Optional) Persist scan history on host
# docker run --rm -p 8787:8787 --privileged --cap-add=NET_RAW \
#   -v "$(pwd)/output:/opt/candy/output" candys-crew:latest
