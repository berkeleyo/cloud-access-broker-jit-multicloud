# ARCHITECTURE

## Trust & Federation

- **Azure**: Entra ID PIM for eligible roles. Conditional Access gates (MFA, compliant device, location).
- **AWS**: IAM **Role per account** trusted to your IdP using OIDC/SAML. Use **External ID** and session policy to restrict scope.
- **GCP**: **Workload Identity Federation** pool that trusts your IdP; bind to a minimal‑privilege service account for each project.

## Logical Components
- **Access Requestor** — engineer initiating JIT.
- **Approval Engine** — Entra PIM/Access Packages or ITSM integration.
- **Broker** — glue/automation that exchanges tokens and activates roles.
- **Audit Store** — logs across all clouds, queryable in a SIEM.

## Data Flows
1. User authenticates to IdP → satisfies Conditional Access.
2. Approval engine authorizes request.
3. Broker activates/assumes roles and issues short‑lived creds.
4. Actions executed; logs correlate to request and user principal.
