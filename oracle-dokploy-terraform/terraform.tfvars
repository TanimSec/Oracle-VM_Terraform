# Existing OCI tenancy and API authentication
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaarzvywoutnkzlwsmgvdx3uchuu4xrej5epso6ddp2ov4emorvyoa"
user_ocid        = "ocid1.user.oc1..aaaaaaaawzvcvsftb6ofgmcad25pqlb3lnfflhdww3wr4mzbszxo54pxtkpq"
fingerprint      = "f2:ef:0b:b5:bf:8a:f2:7b:b0:2c:d3:8c:db:cd:92:a2"
private_key_path = "D:/devops/Oracle/pem/contact.trahmantanim@gmail.com-2026-10-26T19_10_21.283Z.pem"
region           = "ap-mumbai-1"
compartment_ocid = "ocid1.tenancy.oc1..aaaaaaaaarzvywoutnkzlwsmgvdx3uchuu4xrej5epso6ddp2ov4emorvyoa"

# Original Ubuntu 24.04 ARM64 image
image_ocid = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa2jurqb3jm7hlpqw3au35loaqjkcozbyh7znn4jnfu5zbrgfulwia"

# New SSH identity — only for a new instance or after installing this key
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCawpElc1+H5Pygw5Bqnv1upluoIhcyukQQnnU+QdYg oracle-dokploy"
allowed_admin_ips = [
  "103.95.208.0/24",
]

# Original infrastructure settings
instance_name   = "dokploy-server"
vcn_cidr        = "10.0.0.0/16"
subnet_cidr     = "10.0.0.0/24"
ocpus           = 2
memory_gbs      = 12
boot_volume_gbs = 50