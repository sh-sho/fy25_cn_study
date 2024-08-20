variable "source_ocid" {
  type = string
  default = "ocid1.image.oc1.phx.aaaaaaaa6dxlvblwz5msd3cqlmuy4inpytvsbjwyecpstlvak3llgyt4oqba"
}

variable "subnet_ocid" {
  type = string
}
variable "display_vnic_name" {
  type = string
  default = "vnic_sobata"
}

variable "display_instance_name" {
  type = string
  default = "tf-sobata"
}

variable "shape" {
  type = string
  default = "VM.Standard.E4.Flex"
}
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
  type = string
}
variable "public_ssh_key_path" {
  type = string
}

variable "region" {
  default = "us-phoenix-1"
}

variable "compartment_ocid" {
  type = string
}

variable "public_secret_ocid" {
  type = string
}

variable "private_secret_ocid" {
  type = string
}
