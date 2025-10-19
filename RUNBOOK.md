# RUNBOOK — Cloud Access Broker (JIT, Multi‑Cloud)

> **Audience**: On‑call engineers & platform admins  
> **Goal**: Safely grant and revoke time‑bound privileged access in Azure, AWS, and GCP.

---

## 1) Pre‑requisites
- User is in the **Privileged Access** Entra group and has a compliant device.
- Change/Incident reference available.
- Target cloud/account/project onboarded with roles below.

## 2) Request
1. Engineer submits a JIT request with: scope, role, duration (≤ 60m), and ticket ID.
2. Approval via Entra PIM (or ServiceNow → Entra).

## 3) Grant (per cloud)
- **Azure**: Activate eligible PIM role for target subscription/resource group. Require MFA + Conditional Access (compliant device).
- **AWS**: Use External ID + `AssumeRole`. Enforce session duration ≤ 60m.
- **GCP**: Use Workload Identity Federation to mint short‑lived tokens bound to the user/session.

## 4) Operate
- Engineer performs only the approved task. Keep console/CLI session limited to scope.
- All changes must reference the ticket in change notes/commit messages where possible.

## 5) Revoke
- Access auto‑expires. If manual revoke is needed:
  - Azure: Revoke PIM activation.
  - AWS: Invalidate credentials; consider session policy with tight TTL.
  - GCP: Revoke token / disable binding.

## 6) Audit
- Confirm entries in Entra/Azure Activity, CloudTrail, and GCP Audit Logs.
- Record outcome against the ticket. Attach CLI transcripts where relevant.

## 7) Break‑glass
- Held in a sealed envelope (HSM/Password Safe) with dual control. 15‑minute max, post‑use review mandatory.

## 8) Troubleshooting
- Denied by Conditional Access → verify device compliance & location.
- STS access denied → check External ID, role trust policy, and session policy.
- WIF token errors → check OIDC issuer/audience and service account bindings.
