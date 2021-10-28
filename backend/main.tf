module "backend" {
  source         = "../reource-provisioning/modules/backend"
  backend_bucket = var.backend_bucket
  dynamodb_lock_table_name = var.dynamodb_lock_table_name
}

provider "aws" {
     region = "us-east-2"  
 }