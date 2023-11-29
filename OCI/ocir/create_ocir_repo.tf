# creating compartment which will be under root compartment
resource "oci_identity_compartment" "vasu-resource1" {
    compartment_id = var.oci_compartment-id # root compartment id
    name = "vasu-terraform"
    description = "all my resources will be here"
    
}
 
# use alternativ
resource "oci_artifacts_container_repository" "vasu-repo" {
    compartment_id = oci_identity_compartment.vasu-resource1.id
    display_name = "vasu-repo1"
    is_public = false
  
}
