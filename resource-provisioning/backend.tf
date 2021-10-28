terraform {
  backend "s3" {
      region        = "us-east-2"
      bucket        = "infra-common-resource-env-state"
      key           = "terraform.tfstate"
      dynamodb_table = "infra-common-resource-env-state-lock"
      encrypt        = true
    
  }
}