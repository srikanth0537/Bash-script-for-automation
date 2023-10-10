#!/bin/bash

# Function to create an S3 bucket
create_s3_bucket() {
    echo "Enter a unique S3 bucket name:"
    read s3_bucket_name
    aws s3api create-bucket --bucket "$s3_bucket_name"
    echo "S3 bucket '$s3_bucket_name' created successfully."
}

# Function to delete an S3 bucket
delete_s3_bucket() {
    echo "Enter the name of the S3 bucket to delete:"
    read s3_bucket_name
    aws s3api delete-bucket --bucket "$s3_bucket_name" --force
    echo "S3 bucket '$s3_bucket_name' deleted successfully."
}

# Function to create an EC2 instance
create_ec2_instance() {
    echo "Enter the name of the EC2 key pair (existing or new):"
    read key_name
    aws ec2 create-key-pair --key-name "$key_name"
    
    echo "Enter the EC2 instance type (e.g., t2.micro):"
    read instance_type
    
    echo "Enter the ID of the Amazon Machine Image (AMI) to use (e.g., ami-xxxxxxxxxxxxxxxxx):"
    read ami_id
    
    aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name"
    
    echo "EC2 instance created successfully."
}

# Function to delete an EC2 instance
delete_ec2_instance() {
    echo "Enter the ID of the EC2 instance to delete:"
    read instance_id
    aws ec2 terminate-instances --instance-ids "$instance_id"
    echo "EC2 instance '$instance_id' terminated successfully."
}

# Main menu
while true; do
    echo "Select an option:"
    echo "1. Create S3 Bucket"
    echo "2. Delete S3 Bucket"
    echo "3. Create EC2 Instance"
    echo "4. Delete EC2 Instance"
    echo "5. Exit"
    read choice
    
    case $choice in
        1) create_s3_bucket ;;
        2) delete_s3_bucket ;;
        3) create_ec2_instance ;;
        4) delete_ec2_instance ;;
        5) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
