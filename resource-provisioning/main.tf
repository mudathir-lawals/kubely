terraform {
  required_version = ">= 0.14"
}

provider "aws" {
  region = var.region
    # access_key          = var.AWS_ACCESS_KEY_ID
    # secret_key          = var.AWS_SECRET_ACCESS_KEY
}
provider "aws" {
  region = "us-west-2"
  alias  = "certificates"
}

provider "aws" {
  region = "us-west-2"
  alias  = "dns"
}

resource "aws_route53_zone" "default" {
  name = "wayagram.com"
}

#######################################
#AWS VPC, SUBNETS AND NETWORK SETUP
#######################################
module "network" {
  source                = "./modules/network/vpc"
  name                  = var.name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  create_nat_gateways   = true
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  enable_dns_hostnames  = var.enable_dns_hostnames
  environment           = var.environment
  tags                  = {
    terraform           = "True"
    environment         = "common-resources"
  }
}


#######################################
#PRITUNL VPN SETUP
#######################################
# module "jenkins" {
#   source = "cloudposse/jenkins/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   # version = "x.x.x"
#   namespace   = var.namespace
#   stage       = var.stage
#   name        = var.name
#   description = var.description

#   master_instance_type = var.master_instance_type
#   aws_account_id       = var.aws_account_id
#   region               = var.region
#   availability_zones   = var.availability_zones
#   vpc_id               = module.network.vpc_id
#   dns_zone_id          = var.dns_zone_id
#   loadbalancer_subnets = module.network.public_subnet_ids
#   application_subnets  = module.network.private_subnet_ids

#   environment_type                       = var.environment_type
#   loadbalancer_type                      = var.loadbalancer_type
#   loadbalancer_certificate_arn           = var.loadbalancer_certificate_arn
#   availability_zone_selector             = var.availability_zone_selector
#   rolling_update_type                    = var.rolling_update_type
#   loadbalancer_logs_bucket_force_destroy = var.loadbalancer_logs_bucket_force_destroy
#   cicd_bucket_force_destroy              = var.cicd_bucket_force_destroy

#   github_oauth_token  = var.github_oauth_token
#   github_organization = var.github_organization
#   github_repo_name    = var.github_repo_name
#   github_branch       = var.github_branch

#   image_tag = var.image_tag

#   healthcheck_url = var.healthcheck_url

#   build_image        = var.build_image
#   build_compute_type = var.build_compute_type

#   efs_backup_schedule           = var.efs_backup_schedule
#   efs_backup_start_window       = var.efs_backup_start_window
#   efs_backup_completion_window  = var.efs_backup_completion_window
#   efs_backup_cold_storage_after = var.efs_backup_cold_storage_after
#   efs_backup_delete_after       = var.efs_backup_delete_after

#   env_vars = {
#     "JENKINS_USER"          = var.jenkins_username
#     "JENKINS_PASS"          = var.jenkins_password
#     "JENKINS_NUM_EXECUTORS" = var.jenkins_num_executors
#   }
# }
# module "jenkins" {
#   source            = "github.com/odenigbojohnmary/terraform-aws-jenkins.git?ref=master"
#   namespace   = var.namespace
#   stage       = var.stage
#   name        = var.name
#   description = var.description

#   s3logs                       = "false"
#   master_instance_type = var.master_instance_type
#   aws_account_id       = var.aws_account_id
#   region               = var.region
#   availability_zones   = var.availability_zones
#   vpc_id               = module.network.vpc_id
#   dns_zone_id          = var.dns_zone_id
#   loadbalancer_subnets = module.network.public_subnet_ids
#   application_subnets  = module.network.private_subnet_ids

#   domain_name = var.domain_name
#   solution_stack_name = var.solution_stack_name
#   environment_type                       = var.environment_type
#   loadbalancer_type                      = var.loadbalancer_type
#   loadbalancer_certificate_arn           = var.loadbalancer_certificate_arn
#   availability_zone_selector             = var.availability_zone_selector
#   rolling_update_type                    = var.rolling_update_type
#   loadbalancer_logs_bucket_force_destroy = var.loadbalancer_logs_bucket_force_destroy
#   cicd_bucket_force_destroy              = var.cicd_bucket_force_destroy
#   github_oauth_token                     = var.github_oauth_token
#   github_organization                    = var.github_organization
#   github_repo_name                       = var.github_repo_name
#   github_branch                          = var.github_branch

#   image_tag = var.image_tag

#   healthcheck_url = var.healthcheck_url

#   build_image        = var.build_image
#   build_compute_type = var.build_compute_type

#   efs_backup_schedule           = var.efs_backup_schedule
#   efs_backup_start_window       = var.efs_backup_start_window
#   efs_backup_completion_window  = var.efs_backup_completion_window
#   efs_backup_cold_storage_after = var.efs_backup_cold_storage_after
#   efs_backup_delete_after       = var.efs_backup_delete_after

#   env_vars = {
#     "JENKINS_USER"          = var.jenkins_username
#     "JENKINS_PASS"          = var.jenkins_password
#     "JENKINS_NUM_EXECUTORS" = var.jenkins_num_executors
#   }
# }


