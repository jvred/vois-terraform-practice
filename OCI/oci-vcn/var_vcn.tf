variable "oci_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}
 
variable "oci_compartment-id" {
    type = string
    default = "ocid1.compartment.oc1..aaaaaaaalxfg47lum63hbcxxxy6rzfdroljoqq6kx7lpis26npyiutndf7kq"
  
}

variable "vcn_public_subnet" {
  type    = string
  default = "10.0.10.0/24"
}
# private subnet
variable "vcn_private_subnet" {
  type    = string
  default = "10.0.20.0/24"
}
