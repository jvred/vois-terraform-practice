terraform {
  required_providers {
    oci = {
      source  = "oracle/oci" # from terraform and oci
      version = ">= 4.0.0" # provider version
    }
  }
 
}

provider "oci" {
    region = var.my-oci-region
    tenancy_ocid    = var.my-oci-tenancy_id 
    user_ocid = var.my-oci-user_ocid
    fingerprint = "a3:e6:7c:16:55:2a:01:0c:03:45:88:e2:48:0d:3b:15"
    private_key_path = "/home/ashu/.oci/private_key.pem"
}

