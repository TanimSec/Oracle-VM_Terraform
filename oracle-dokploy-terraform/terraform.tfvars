# Oracle Cloud Terraform variables
# Fill in remaining CHANGE_ME placeholders with your own values.
# Keep your OCI API private key file on your PC; do not paste its contents here.
# ssh_public_key must be your SSH PUBLIC key (.pub), never your private key.

tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaarzvywoutnkzlwsmgvdx3uchuu4xrej5epso6ddp2ov4emorvyoa"
user_ocid        = "ocid1.user.oc1..aaaaaaaawzvcvsftb6ofgmcad25pqlb3lnfflhdww3wr4mzbszxo54pxtkpq"
fingerprint      = "f2:ef:0b:b5:bf:8a:f2:7b:b0:2c:d3:8c:db:cd:92:a2"
private_key_path = "D:/devops/Oracle/pem/contact.trahmantanim@gmail.com-2026-10-26T19_10_21.283Z.pem"
region           = "ap-mumbai-1"
compartment_ocid = "ocid1.tenancy.oc1..aaaaaaaaarzvywoutnkzlwsmgvdx3uchuu4xrej5epso6ddp2ov4emorvyoa"

image_ocid = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa2jurqb3jm7hlpqw3au35loaqjkcozbyh7znn4jnfu5zbrgfulwia"

ssh_public_key   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/9mM7KinpimjR0pImFiL3jiJeCAyyn3CrsXGtXv3i9 oracle-dokploy"
ssh_ingress_cidr = "103.95.208.47/32"

instance_name   = "dokploy-server"
vcn_cidr        = "10.0.0.0/16"
subnet_cidr     = "10.0.0.0/24"
ocpus           = 2
memory_gbs      = 12
boot_volume_gbs = 50
