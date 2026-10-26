# Oracle Cloud Always Free Dokploy VM — Terraform starter

This Terraform configuration creates a VCN, internet gateway, public route table, subnet, security list, and VM.Standard.A1.Flex instance. It does not install Dokploy automatically.

## Important
- Terraform cannot bypass Oracle A1 capacity errors. If Mumbai has no A1 capacity, apply will fail too.
- Verify Always Free eligibility and current limits before creating resources. Intended target is up to 2 OCPUs, 12 GB RAM, and a 47 GB boot volume, assuming no other resources consume the free allowance.
- This creates a new VCN. If you already made a VCN/subnet manually, either reuse that network by modifying this config or ensure the old unused network is not left unnecessarily.
- SSH is restricted to `ssh_ingress_cidr`; set it to your public IPv4 address plus `/32`.
- Never put your SSH private key in `ssh_public_key`. Only the `.pub` public key goes there. Keep `terraform.tfvars` and `terraform.tfstate` private.

## 1. Set up OCI API signing credentials
In OCI Console: profile → My profile → API keys → Add API key. Download the API private key and copy the config values Oracle displays. Never share the private key.

Install Terraform for Windows: https://developer.hashicorp.com/terraform/install
OCI API signing keys: https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm

## 2. Get the image OCID
In Mumbai, open Compute → Instances → Create instance → Change image and choose **Canonical Ubuntu 24.04 Minimal aarch64**. Copy its image OCID. A1 is ARM64; do not use an x86 image.

## 3. Configure values
Copy `terraform.tfvars.example` to `terraform.tfvars`. Replace all placeholders with your actual tenancy/user/fingerprint/compartment values, API key path, image OCID, SSH public key, and your public IP `/32`.

## 4. Preview first
Open PowerShell in this folder and run:

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
```

Read the plan carefully before applying.

## 5. Create the resources

```powershell
terraform apply
```

Type `yes` only after reviewing the plan. If OCI reports `Out of capacity for shape VM.Standard.A1.Flex`, wait and retry; Terraform cannot reserve capacity.

## 6. Connect and install Dokploy
Get the public IP:

```powershell
terraform output -raw public_ip
```

SSH with the private key matching the public key configured in `terraform.tfvars`:

```powershell
ssh -i "C:\path\to\your\ssh_private_key" ubuntu@PUBLIC_IP
```

On the VM, run Dokploy's official installer:

```bash
curl -sSL https://dokploy.com/install.sh | sh
```

Then open `http://PUBLIC_IP:3000` for initial setup. Configure a domain and HTTPS afterward. Keep ports 80 and 443 open. Consider restricting port 3000 after initial setup.

Dokploy installation docs: https://docs.dokploy.com/docs/core/installation

## 7. Destroy if needed

```powershell
terraform destroy
```

Review the destruction plan carefully; it deletes the resources managed by this state, including the VM and boot volume. Back up anything important first.
