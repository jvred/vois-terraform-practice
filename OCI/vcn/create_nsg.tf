resource "oci_core_network_security_group" "test_network_security_group" {
    #Required
    compartment_id = var.oci_compartment-id
    vcn_id = oci_core_vcn.vasu_oke_vcn-new.id
}
resource "oci_core_network_security_group_security_rule" "allow_ssh" {
  network_security_group_id = oci_core_network_security_group.test_network_security_group.id
  direction                = "INGRESS"
  description              = "Allow SSH traffic"
  protocol                 = "6"
  source_type              = "CIDR_BLOCK"
  source                   = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}
 
resource "oci_core_network_security_group_security_rule" "allow_http" {
  network_security_group_id = oci_core_network_security_group.test_network_security_group.id
  direction                = "INGRESS"
  description              = "Allow http traffic"
  protocol                 = "6"
  source_type              = "CIDR_BLOCK"
  source                   = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}
