# Wallester Infrastructure as Code (IaC) Terraform Modules

This repository contains reusable Terraform modules for provisioning AWS infrastructure in a version-controlled manner.
`Latest version: v1.5.0`

## Modules

- **VPC**: Creates a Virtual Private Cloud with public and private subnets, route tables, NAT Gateway, Internet Gateway and adding EKS required tags to the subnets.
  - Will create private subnets and public subnets in different AZ. It dynamically provisions the number of subnets based on the value we provide. (in this example, 6 subnets. Max 6). 
  - Subnet CIDR calculation is done using the terraform function cidrsubnet()
  - AZ selection is also done using the modulus terraform operator.
  - Routing tables will be created (private, public)
  - NAT GW to route private instance traffic to the internet. 
  - Available AZs in the region will be retrieved using a data block. 

- **EC2-HA**: Provisions highly available EC2 instances to host the workload for Task 01.
  - Uses an Auto Scaling Group (ASG) with a Launch Template for high availability.
  - Attach two 10 GB Elastic Block Store (EBS) volumes to the EC2 instance.
  - An Amazon Linux 2023 ARM64-based AMI is used, as Graviton instances run on the ARM64 platform.
  - Install Nginx on the EC2 instances.

- **EKS**: Provisions EKS cluster, worker nodes and ALB Security Group to host Application workload for Task 02.
  - Uses AWS managed instances to run the workloads
  - AWS Graviton instances (t4g.small) are using as it offer a balance of performance and cost-effectiveness
  - Amazon Linux 2023 ARM64 based AMI is used as Graviton instances runs on ARM64 platform
  - Setup EKS cluster add-ons: kube-proxy, pod-identity, vpc-cni, core-dns, external-dns
  - Installs AWS Loadbalancer Controller. AWS LBC will handle the ALB creation and exposing the application to the outside.
  - Installs Kubernetes Cluster Autoscaler. AWS uses an Auto Scaling Group to manage the worker nodes. 
  - Based on the resource consumption of the nodes, the Cluster Autoscaler automatically scales the number of worker nodes in or out.

- **ELB**: Creates an Application Load Balancer (ALB) for Task 01.
  - Uses the Auto Scaling Group (ASG) of EC2 instances created by the EC2-HA module as the target group.
  - Creates an ALB security group allowing inbound traffic on ports 80 and 443 from 88.196.208.91/32

- **DNS**:
  - Creates a Public Hosted Zone for the domain in Route53.
  - Requests a SSL certificate for the domain.
  - Adds the CNAME record in Route53 for SSL validation.



## Usage

Each module can be integrated into Terraform configuration by specifying its source. 

```hcl
module "eks" {

  source = "git::https://github.com/sarithekanayake/wallester-idp-modules.git//vpc?ref=v1.5.0"

  env                =  "wallester"
  vpc_id             =  "vpc-0123456789abcdefg"
  private_subnet_ids =  ["subnet-0123456789abcdefg","subnet-abcdefg0123456789"]
  public_subnet_ids  =  ["subnet-0123456789hijklmn","subnet-hijklmn0123456789"]
  
  eks_name           =  "wallester-eks"
  eks_version        =  "1.33"

  #worker node specs
  desired_size       =  2
  max_size           =  5
  min_size           =  1

}
```