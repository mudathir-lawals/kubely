#!/bin/bash

set -xeo pipefail


    cd ./backend &&
     if aws s3 ls "s3://infra-common-resource-env-state" 2>&1 | grep -q "NoSuchBucket";
     then 
     terraform get -update &&
     terraform init -no-color -input=false &&
     terraform plan -out=./backend.plan -target=module.backend -var-file=../reource-provisioning/terraform.tfvars &&
     terraform apply -auto-approve "./backend.plan";
     fi &&
    cd ../reource-provisioning &&
     terraform init -reconfigure -input=false &&
     terraform init -no-color -input=false &&
     terraform plan -input=false -target=module.network -out=./vpc.state &&
     terraform apply  -input=false -target=module.network -auto-approve "./vpc.state" &&
     terraform plan -input=false -target=module.jenkins -out=./jenkins.state &&
     terraform apply  -input=false -target=module.jenkins -auto-approve "./jenkins.state" &&

    # This is very destructive never uncomment here please
    # terraform destroy -input=false -auto-approve  &&

    echo "done"