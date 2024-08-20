terraform {
  backend "http" {
    address = "https://objectstorage.ap-tokyo-1.oraclecloud.com/p/DZUls75o09k_LsSavgdiR4nEN84YhPijEh_8UMKHZTAyezZXpHFH0KayDIJtxar0/n/orasejapan/b/terraform_back/o/terraform.state"
    update_method = "PUT"
  }
}





