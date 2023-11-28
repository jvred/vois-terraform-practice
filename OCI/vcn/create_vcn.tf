resource "oci_core_vcn" "vasu_oke_vcn-new" {
 
    cidr_block = var.oci_cidr
    dns_label = "vasuvcn1"
    compartment_id = var.oci_compartment-id
    display_name = "vasu-terraform-vcn-new"
}
resource "oci_core_subnet" "public_subnet" {
    cidr_block     = var.vcn_public_subnet
    display_name   = "vasu-PublicSubnet"
    vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
    compartment_id = var.oci_compartment-id
    # adding routing table
    route_table_id = oci_core_route_table.vasupublic_route_table.id
}
resource "oci_core_subnet" "private_subnet" {
    cidr_block     = var.vcn_private_subnet
    display_name   = "vasu-PrivateSubnet"
    vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
    compartment_id = var.oci_compartment-id
}
# creating Nat gateway
resource "oci_core_nat_gateway" "vasu_nat_gateway" {
  compartment_id = var.oci_compartment-id
  vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
  display_name   = "vasuNatGateway"
  block_traffic = false  # to allow any outgoing traffic
}
# creating routing rules with nat gw
resource "oci_core_route_table" "private_route_table" {
  compartment_id = var.oci_compartment-id
  display_name   = "vasu-private-route-table"
  vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id

# routing rule
route_rules {
  destination          = "0.0.0.0/0"
  destination_type     = "CIDR_BLOCK"
  #network_entity_type  = "NAT_GATEWAY"
  network_entity_id    = oci_core_nat_gateway.vasu_nat_gateway.id
  }
}


# creating Internet gateway
resource "oci_core_internet_gateway" "vasu_internet_gateway" {
  compartment_id = var.oci_compartment-id
  vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
  display_name   = "VasuInternetGateway"
}

# creating routing table
resource "oci_core_route_table" "vasupublic_route_table" {
  compartment_id = var.oci_compartment-id
  display_name   = "vasu-public-route-table"
  vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
 
  route_rules {
    destination           = "0.0.0.0/0"
    destination_type      = "CIDR_BLOCK"
    #network_entity_type   = "INTERNET_GATEWAY"
    network_entity_id = oci_core_internet_gateway.vasu_internet_gateway.id
    }
}

# creating security list
resource "oci_core_security_list" "vasu_security_list" {
  compartment_id = var.oci_compartment-id
  vcn_id         = oci_core_vcn.vasu_oke_vcn-new.id
  display_name   = "vasu-SecurityList"
 
  egress_security_rules {
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
    protocol         = "all"
  }
# for ssh
  ingress_security_rules {
    source_type      = "CIDR_BLOCK"
    source           = "0.0.0.0/0"
    protocol         = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }
  # http
  ingress_security_rules {
    source_type      = "CIDR_BLOCK"
    source           = "0.0.0.0/0"
    protocol         = "6"
    tcp_options {
      min = 80
      max = 80
    }
  }
}
