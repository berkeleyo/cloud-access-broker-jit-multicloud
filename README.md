# Cloud Access Broker — Just‑in‑Time (JIT) Admin for Multi‑Cloud (Azure • AWS • GCP) 🚀

![Redaction](https://img.shields.io/badge/Redaction-No%20secrets%2C%20IPs%2C%20or%20tenant%20data-brightgreen?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production%20Ready-1f6feb?style=for-the-badge)

> **Concept**: A **provider‑agnostic Cloud Access Broker** that grants **time‑bound, least‑privilege** admin access across **Azure, AWS, and GCP** for support engineers and partners. Built to reflect real MSP experience (e.g., Daisy‑style multi‑tenant operations), balancing **speed of incident response** with **strong guardrails**.

This repository is a production‑grade documentation + runbook pack you can drop into a new GitHub repo. It includes lifecycle stages, cutover and rollback, and clean scripts you can adapt to your own automation.

---

## 🎯 Why this project?
- **JIT elevation** via Entra ID (PIM), AWS STS `AssumeRole` with **External ID**, and GCP **Workload Identity Federation**.
- **Central policy**: requests are approved in Entra or ServiceNow; on approval, short‑lived credentials are issued and auto‑revoked.
- **Audit‑first**: every grant is logged and bound to a change or incident reference.
- **Cloud‑agnostic**: works the same way for Azure subscriptions, AWS accounts, and GCP projects.

---

## 🧭 Lifecycle Stages

1. **Discover** — Inventory identities, roles, and privileged tasks per cloud.
2. **Design** — Define JIT RBAC roles, max durations, and approval flows.
3. **Build** — Provision roles and trust (Azure PIM roles; AWS IAM Roles + External ID; GCP IAM + WIF pool).
4. **Integrate** — Wire approvals (e.g., Entra PIM/Access Packages) and CI/CD (optional GitHub Actions) to mint short‑lived creds.
5. **Pilot** — Run controlled pilots with verbose audit logging.
6. **Harden** — Enforce device posture (Compliance / CA), MFA, IP restrictions, and session recording (where applicable).
7. **Cutover** — Switch operational access to JIT, retire standing admin.
8. **Operate** — Runbooks, monitoring, and periodic access reviews.
9. **Evolve** — Add new clouds/accounts/projects, tune durations, expand automation.

---

## 🗺️ Reference Flow (Mermaid)

```mermaid
sequenceDiagram
  autonumber
  participant Eng as Engineer
  participant CAB as Cloud Access Broker
  participant Entra as Entra ID (PIM/CA)
  participant Azure as Azure
  participant AWS as AWS STS/IAM
  participant GCP as GCP IAM/WIF
  Eng->>CAB: Request JIT role (ticket/ref)
  CAB->>Entra: Validate user, device posture, approval
  Entra-->>CAB: Approval granted + max duration
  CAB->>Azure: Activate eligible PIM role (time-bound)
  CAB->>AWS: AssumeRole with ExternalId (STS creds)
  CAB->>GCP: Exchange via WIF for short-lived token
  Eng-->>Azure: Perform scoped task (audit)
  Eng-->>AWS: Perform scoped task (CloudTrail)
  Eng-->>GCP: Perform scoped task (Audit Logs)
  CAB->>All: Auto-expire & revoke; write audit record
```

---

## 🧩 What’s in this repo?

- `README.md` — You’re here. Project narrative, lifecycle, and diagram.
- `RUNBOOK.md` — Production operations: request, approve, grant, revoke, audit.
- `docs/` — Focused design docs:
  - `OVERVIEW.md` — Executive summary & scope.
  - `ARCHITECTURE.md` — Trust, roles, and data flows.
  - `CUTOVER_CHECKLIST.md` — Go‑live steps with verification gates.
  - `ROLLBACK.md` — Safe fallback to pre‑JIT state.
  - `SECURITY.md` — Controls, risks, and mitigations.
- `scripts/` — Practical starter scripts (bash & PowerShell) + example policy JSON.

> 🔒 **Redaction statement**: This repository contains **no secrets, tenant IDs, public IPs, customer names, or internal identifiers**. Replace all placeholders before use in your environment.

---

## 🧪 Tested clouds (conceptually)

- **Azure**: Entra ID PIM eligible roles (e.g., `User Access Administrator`, custom RBAC), Conditional Access (MFA, compliant device), defender alerts.
- **AWS**: IAM role per account with minimal policy; federation via `AssumeRole` + External ID; session duration ≤ 1h; CloudTrail enabled.
- **GCP**: Workload Identity Federation (OIDC) pool; least‑privilege roles (`roles/viewer` + per‑task), Access Context Manager for device/IP.

---

## 🚀 Getting started

```bash
# Clone your new repo and add this pack
git init
git add .
git commit -m "feat: cloud access broker JIT docs (initial)"
git branch -M main
git remote add origin <your-new-github-repo-url>
git push -u origin main
```

See [`RUNBOOK.md`](./RUNBOOK.md) to operate day‑to‑day.

---

## ✅ Compliance & audit

- All grants map to a **ticket or change ID**.
- Logs in **Entra**, **Azure Activity**, **AWS CloudTrail**, and **GCP Audit Logs**.
- Quarterly access review aligned to ISO 27001/27017 control families.

---

## 📄 License

MIT — use and adapt freely. Keep the redaction posture.
