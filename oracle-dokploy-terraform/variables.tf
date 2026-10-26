variable "tenancy_ocid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "fingerprint" {
  type = string
}
variable "private_key_path" {
  description = "Path to OCI API signing private key PEM"
  type        = string
}
variable "region" {
  type    = string
  default = "ap-mumbai-1"
}
variable "compartment_ocid" {
  type = string
}
variable "image_ocid" {
  description = "Ubuntu 24.04 Minimal aarch64 image OCID in this region"
  type        = string
}
variable "ssh_public_key" {
  description = "Contents of SSH public key (.pub), never private key"
  type        = string
}
variable "ssh_ingress_cidr" {
  description = "Your public IP/32 for SSH access"
  type        = string
}
variable "instance_name" {
  type    = string
  default = "dokploy-server"
}
variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}
variable "ocpus" {
  type    = number
  default = 2
}
variable "memory_gbs" {
  type    = number
  default = 12
}
variable "boot_volume_gbs" {
  type    = number
  default = 47
}
