EC2 Jenkins Deployment
This repository demonstrates the process of provisioning an EC2 instance on AWS and installing Jenkins using a series of scripts. Follow the steps below to deploy and manage the EC2 instance with Jenkins.

Prerequisites
Before you begin, ensure that you have the following installed:

Terraform (for provisioning resources on AWS)
AWS CLI (for configuring AWS credentials)
Git (to clone and work with the repository)
Deployment Steps
Follow the sequence of scripts to deploy an EC2 instance with Jenkins:

1. Run bootstrap.sh
This script will:

Install Terraform and AWS CLI on your machine.
Run terraform init to initialize Terraform and download necessary providers.

2. Run configure-aws.sh
This script will:

Take your AWS Access Key ID as the first argument and AWS Secret Access Key as the second argument.
Configure the AWS CLI with these credentials to allow communication with your AWS account.
Usage:

./configure-aws.sh <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY>

3. Run provision-EC2-Instance.sh
This script will:

Provision an EC2 instance using Terraform.
Install Jenkins on the EC2 instance.
Print the Jenkins URL and first-time admin password to the standard output.
After running the script, you will see the URL to access Jenkins and the first-time login credentials.

4. Run destroy-hardware.sh
This script will:

Destroy the EC2 instance and all associated resources provisioned by Terraform.
Clean up the environment after you're done with the EC2 instance.

5. login-to-created-instance.sh
This is a temporary script generated after the EC2 instance is provisioned.
It will be used to log into the EC2 instance.

Notes

Temporary Scripts: The login-to-created-instance.sh script is ephemeral, created once the instance is up and removed once the instance is destroyed. It is automatically ignored by Git (due to being listed in .gitignore).

Terraform: Ensure that you have the correct AWS credentials and permissions to provision resources on AWS, including EC2 instances.

Example of Running the Scripts

Run bootstrap.sh to install the required tools:
./bootstrap.sh

Configure AWS CLI with your credentials:
./configure-aws.sh <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY>

Provision the EC2 instance and install Jenkins:
./provision-EC2-Instance.sh

Destroy the EC2 instance when you're done:
./destroy-hardware.sh

Contributing
Feel free to fork this repository, make changes, and open pull requests. Contributions are always welcome.

