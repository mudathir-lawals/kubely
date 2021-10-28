region                          = "us-east-2"
name                            = "Waya-infra-common"
environment                     = "common-resource"
stage                           = "mgt"
namespace                       = "resources"
availability_zones              =  [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c",
  ]
vpc_cidr                        =  "10.20.0.0/16"
public_subnet_cidrs             =  [
    "10.20.10.0/24",
    "10.20.11.0/24",
  ]
private_subnet_cidrs            = [
    "10.20.1.0/24",
    "10.20.2.0/24",

  ]
assign_generated_ipv6_cidr_block = false
enable_dns_hostnames             =  true
backend_bucket = "infra-common-resource-env-state"
dynamodb_lock_table_name = "infra-common-resource-env-state-lock"

######################
#JENKINS  SETUP
######################
# aws_account_id = "863852973330"
# description = "Jenkins server as Docker container running on Elastic Benastalk"
# master_instance_type = "t3.medium"
# healthcheck_url = "/login"
# domain_name = "jenkins"
# # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
# # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
# solution_stack_name = "64bit Amazon Linux 2018.03 v2.14.3 running Docker 18.09.9-ce"
# dns_zone_id = "Z103330132CSJQ74MQWS6"
# availability_zone_selector = "Any"
# environment_type = "LoadBalanced"
# loadbalancer_type = "application"
# loadbalancer_certificate_arn = "arn:aws:acm:us-east-2:863852973330:certificate/5b29a10c-61f4-4895-8346-b0216caf3be0"
# loadbalancer_logs_bucket_force_destroy = true
# cicd_bucket_force_destroy = true
# rolling_update_type = "Health"

# # `github_oauth_token` is required for CodePipeline to download the Jenkins repo from GitHub
# # Can be provided in `TF_VAR_github_oauth_token` environment variable
# github_oauth_token = "OAUTH_TOKEN"
# github_organization = "odenigbojohnmary"
# github_repo_name = "terraform-aws-jenkins"
# github_branch = "master"
# # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
# build_image = "aws/codebuild/docker:1.12.1"
# # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html
# build_compute_type = "BUILD_GENERAL1_SMALL"
# image_tag = "latest"
# efs_backup_schedule = "cron(0 12 * * ? *)"
# efs_backup_start_window = 60
# efs_backup_completion_window = 120
# efs_backup_cold_storage_after = 30
# efs_backup_delete_after = 180
# jenkins_username = "admin"
# jenkins_password = "1234567"
# jenkins_num_executors = 2


