# SECURITY

- **Least Privilege**: Task‑focused custom roles, session policies.
- **Identity Assurance**: MFA + device compliance; conditional access by location if required.
- **Session Limits**: Max 60 minutes with justifications required beyond 30.
- **Logging**: Entra sign‑in logs, Azure Activity, CloudTrail, GCP Audit Logs shipped to SIEM.
- **Separation of Duties**: Approvers cannot self‑approve; break‑glass dual control.
- **Key Management**: No secrets in repo. Use Key Vault/Secrets Manager/Secret Manager in runtime systems.
- **Redaction**: This repo is scrubbed of IPs, tenant IDs, org names, and customer data.
