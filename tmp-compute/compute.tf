# availability-domain
data "oci_identity_availability_domains" "ads" {
    compartment_id = "${var.compartment_ocid}"
}

# data "oci_vault_secret" "public_ssh_key_secret" {
#     secret_id = "${var.public_secret_ocid}"
# }

# data "oci_vault_secret" "private_ssh_key_secret" {
#     secret_id = "${var.private_secret_ocid}"
# }

locals {
    availability_domain_name = data.oci_identity_availability_domains.ads.availability_domains[0].name
    # public_ssh_key_secret = data.oci_vault_secret.public_ssh_key_secret.secret_content[0].content
}

# compute
resource "oci_core_instance" "ubuntu_instance" {
    availability_domain = "${local.availability_domain_name}"
    compartment_id = "${var.compartment_ocid}"
    shape = "${var.shape}"
    create_vnic_details {
        display_name = "${var.display_vnic_name}"
        assign_public_ip = true
        subnet_id = "${var.subnet_ocid}"
    }
    # freeform_tags = {"Auto-Start"= "7"}
    display_name = "${var.display_instance_name}"
    
    shape_config {
        baseline_ocpu_utilization = "BASELINE_1_2"
        memory_in_gbs = 64
        ocpus = 2
    }
    source_details {
        source_id = "${var.source_ocid}"
        source_type = "image"
        boot_volume_size_in_gbs = 100
    }
    preserve_boot_volume = false
    metadata = {
        ssh_authorized_keys = file("${var.public_ssh_key_path}")
        # ssh_authorized_keys = local.public_ssh_key_secret

        user_data = "${base64encode(file("./instance_init/install_init.yaml"))}"
    }
}
