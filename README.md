🧭 Step-by-Step Execution Guide (As per GitHub README)
✅ STEP 1: Prerequisites

Before starting, ensure you have:

AWS Account

IAM User with permissions:

EC2

VPC

ECR

IAM

Git installed

Terraform installed

Docker installed (local optional)

GitHub account

✅ STEP 2: Clone the GitHub Repository
git clone https://github.com/reddy-b55/ci-cd-terraform.git
cd ci-cd-terraform

✅ STEP 3: Terraform Infrastructure Setup

Navigate to Terraform directory:

cd cicd-terraform

Initialize Terraform
terraform init

Validate Configuration
terraform validate

Review Execution Plan
terraform plan

Provision Infrastructure
terraform apply


Type yes when prompted.

✅ STEP 4: Access Jenkins Server

After Terraform completes, note the output:

ec2_ip = <PUBLIC_IP>

Open Jenkins in Browser
http://<EC2_PUBLIC_IP>:8080

✅ STEP 5: Jenkins Initial Setup
SSH into EC2
ssh -i devops-key ubuntu@<EC2_PUBLIC_IP>

Get Jenkins Admin Password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Jenkins UI Setup

Paste admin password

Select Install Suggested Plugins

Create Admin User

✅ STEP 6: Install Required Jenkins Plugins

Navigate to:

Manage Jenkins → Plugins


Install:

Git

Pipeline

Docker Pipeline

AWS Credentials

Amazon ECR

Credentials Binding

Restart Jenkins if prompted.

✅ STEP 7: Create AWS ECR Repository

From local or EC2:

aws ecr create-repository \
  --repository-name myapp \
  --region us-east-1


Note the repository URI:

123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp

✅ STEP 8: Configure Jenkins Credentials

Go to:

Manage Jenkins → Credentials → Global → Add Credentials


Add:

Field	Value
Kind	AWS Credentials
ID	aws-creds
Access Key	IAM Access Key
Secret Key	IAM Secret Key
✅ STEP 9: Create Jenkins Pipeline Job

Jenkins Dashboard → New Item

Name: ci-cd-pipeline

Type: Pipeline

Pipeline Definition:

Pipeline script from SCM

SCM: Git

Repo URL:

https://github.com/reddy-b55/ci-cd-terraform.git


Branch: main

Script Path: Jenkinsfile

Save

✅ STEP 10: Jenkins Pipeline Execution

Trigger build manually or via GitHub push.

Pipeline Stages
Checkout Code
↓
Build Docker Image
↓
Login to AWS ECR
↓
Push Image to ECR
↓
Pull Image on EC2
↓
Run Container

✅ STEP 11: Verify Deployment
Jenkins

Build Status → SUCCESS

EC2
docker ps

Application Access
http://<EC2_PUBLIC_IP>

🔁 STEP 12: Automated CI/CD Flow

Any new commit to GitHub:

git add .
git commit -m "feature update"
git push origin main


Automatically triggers:

GitHub → Jenkins → Docker → ECR → EC2

🧠 Best Practices Followed

Infrastructure as Code (Terraform)

Immutable Docker images

Secure credential management

No secrets in Git

Repeatable deployments
