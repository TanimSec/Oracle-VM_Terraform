output "instance_name" {
  value = oci_core_instance.dokploy.display_name
}
output "public_ip" {
  value = oci_core_instance.dokploy.public_ip
}
output "ssh_command" {
  value = "ssh ubuntu@${oci_core_instance.dokploy.public_ip}"
}
output "vcn_id" {
  value = oci_core_vcn.dokploy.id
}
output "subnet_id" {
  value = oci_core_subnet.dokploy.id
}
