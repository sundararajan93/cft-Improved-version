#!/bin/bash

echo -e "Creating Stack ....."

export AWS_ACCESS_KEY_ID=$ACCESS_KEY && \
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY

STACK_NAME=$1

aws cloudformation create-stack --stack-name $1 --template-body file://CFT/CFT-SECRETS.json
echo -e "RDS-DB and EC2 instance will be up in few moments...\n"
aws cloudformation wait stack-create-complete --stack-name $1

echo -e "Stack Created Successfully !!! \n"
EC2=$(aws cloudformation describe-stack-resources --stack-name $1 | grep "PhysicalResourceId" | grep "i-" | sed -e 's/^[[:space:]]*//' | awk '{print $2}' | cut -d "\"" -f 2)
RDS=$(aws rds describe-db-instances --db-instance-identifier wikidemo | grep Address | sed -e 's/^[[:space:]]*//' | awk '{print $2}' | cut -d "\"" -f 2)
EC2_PublicIP=$(aws ec2 describe-instances --instance-ids $EC2 | grep PublicIpAddress | sed -e 's/^[[:space:]]*//' | awk '{print $2}' | cut -d "\"" -f 2)

echo -e "RDS and EC2 Details \n"
echo "EC2 Instance ID: $EC2"
echo "EC2 Instance Public IP: $EC2_PublicIP"
echo "RDS EndPoint: $RDS"

### Need to add the Public IP automatically to host file and RDS endpoint to mysql Conf