data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

resource "oci_core_vcn" "dokploy" {
  compartment_id = var.compartment_ocid
  display_name   = "dokploy-vcn"
  cidr_blocks    = [var.vcn_cidr]
  dns_label      = "dokployvcn"
}

resource "oci_core_internet_gateway" "dokploy" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.dokploy.id
  display_name   = "dokploy-internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "dokploy" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.dokploy.id
  display_name   = "dokploy-public-route-table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.dokploy.id
  }
}

resource "oci_core_security_list" "dokploy" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.dokploy.id
  display_name   = "dokploy-security-list"

  dynamic "ingress_security_rules" {
    for_each = var.allowed_admin_ips
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        min = 22
        max = 22
      }
      description = "SSH restricted to admin IP"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
    description = "HTTP"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
    description = "HTTPS"
  }

  dynamic "ingress_security_rules" {
    for_each = var.allowed_admin_ips
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        min = 3000
        max = 3000
      }
      description = "Dokploy dashboard - restricted to admin IP"
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    description = "Outbound traffic"
  }
}

resource "oci_core_subnet" "dokploy" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.dokploy.id
  display_name               = "dokploy-public-subnet"
  cidr_block                 = var.subnet_cidr
  route_table_id             = oci_core_route_table.dokploy.id
  security_list_ids          = [oci_core_security_list.dokploy.id]
  prohibit_public_ip_on_vnic = false
  prohibit_internet_ingress  = false
  dns_label                  = "dokploypub"
}

resource "oci_core_instance" "dokploy" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  display_name        = var.instance_name
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_gbs
  }
  create_vnic_details {
    subnet_id        = oci_core_subnet.dokploy.id
    assign_public_ip = true
    display_name     = "dokploy-primary-vnic"
    hostname_label   = "dokploy"
  }
  source_details {
    source_type             = "image"
    source_id               = var.image_ocid
    boot_volume_size_in_gbs = var.boot_volume_gbs
  }
  metadata             = { ssh_authorized_keys = var.ssh_public_key }
  preserve_boot_volume = false
  lifecycle {
    precondition {
      condition     = var.ocpus > 0 && var.ocpus <= 2
      error_message = "For this Always Free target, use between 1 and 2 OCPUs."
    }
    precondition {
      condition     = var.memory_gbs > 0 && var.memory_gbs <= 12
      error_message = "For this Always Free target, memory must be 12 GB or less."
    }
    precondition {
      condition     = var.boot_volume_gbs >= 47
      error_message = "Oracle boot volume minimum is 47 GB; keep total storage within the Always Free allowance."
    }
  }
}
