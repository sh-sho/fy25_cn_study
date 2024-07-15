# availability-domain
data "oci_identity_availability_domains" "ads" {
    compartment_id = "${var.compartment_ocid}"
}

locals {
    availability_domain_name = data.oci_identity_availability_domains.ads.availability_domains[0].name
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

        user_data = "${base64encode(file("./instance_init/install_init.yaml"))}"
    }
}
