#!/bin/bash

#set -x      # Enable debug mode to trace script execution

# AWS Resource Tracker Script: Tracks & Reports AWS resources (IAM, EC2, S3, RDS, Lambda) usage
# Author: Enhanced Master Version
# Date: 25/12/25
# Version: v2.0
# Usage: ./aws-resource-tracker.sh [region] [--help]

# Help function
show_help() {
    echo "AWS Resource Tracker v2.0"
    echo "Usage: $0 [region] [--help]"
    echo ""
    echo "Options:"
    echo "  region    AWS region to scan (default: us-east-1)"
    echo "  --help    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Use default region"
    echo "  $0 eu-west-1         # Scan eu-west-1 region"
    echo ""
    echo "Prerequisites:"
    echo "  - AWS CLI configured"
    echo "  - jq installed"
    echo "  - Appropriate AWS permissions"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check prerequisites
if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI not found. Please install AWS CLI."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq not found. Please install jq."
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "Error: AWS credentials not configured. Run 'aws configure' first."
    exit 1
fi

REGION=${1:-us-east-1}  # Default region if not provided
# To find your preferred region, use: aws configure get region

echo "AWS Resource Tracker - Region: $REGION"
echo "======================================="

# IAM Users
echo "IAM Users:"
aws iam list-users | jq -r '.Users[].UserName' || echo "No IAM users found or insufficient permissions"

# S3 Buckets
echo -e "\nS3 Buckets:"
aws s3api list-buckets | jq -r '.Buckets[].Name' || echo "No S3 buckets found or insufficient permissions"

# EC2 Instances
echo -e "\nEC2 Instances:"
aws ec2 describe-instances --region $REGION \
  --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType]' \
  --output table || echo "No EC2 instances found or insufficient permissions"

# RDS Instances
echo -e "\nRDS Instances:"
aws rds describe-db-instances --region $REGION \
  --query 'DBInstances[].[DBInstanceIdentifier,DBInstanceStatus,DBInstanceClass]' \
  --output table || echo "No RDS instances found or insufficient permissions"

# Lambda Functions
echo -e "\nLambda Functions:"
aws lambda list-functions --region $REGION \
  --query 'Functions[].[FunctionName,Runtime,LastModified]' \
  --output table || echo "No Lambda functions found or insufficient permissions"

echo -e "\nScan completed for region: $REGION"
