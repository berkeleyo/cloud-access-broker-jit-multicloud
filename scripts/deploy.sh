#!/usr/bin/env bash
set -euo pipefail

# Placeholder script for JIT activation flows across Azure, AWS, and GCP.
# No secrets; replace placeholders before use.

AZ_SUBSCRIPTION_ID="<AZURE_SUBSCRIPTION_ID>"
AZ_ROLE="User Access Administrator"
MINUTES="60"

echo "== Azure PIM activation (placeholder) =="
echo "Activate PIM role '$AZ_ROLE' on subscription $AZ_SUBSCRIPTION_ID for $MINUTES minutes."

echo "== AWS STS AssumeRole (placeholder) =="
AWS_ROLE_ARN="arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME>"
EXTERNAL_ID="<EXTERNAL_ID>"
echo "AssumeRole $AWS_ROLE_ARN with ExternalId $EXTERNAL_ID (<= ${MINUTES}m)."

echo "== GCP WIF exchange (placeholder) =="
WIF_POOL="projects/<PROJECT_NUMBER>/locations/global/workloadIdentityPools/<POOL_ID>"
WIF_PROVIDER="<PROVIDER_ID>"
SA_EMAIL="<SERVICE_ACCOUNT>@<PROJECT_ID>.iam.gserviceaccount.com"
echo "Exchange OIDC via WIF in $WIF_POOL/$WIF_PROVIDER to impersonate $SA_EMAIL."
