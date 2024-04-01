#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = var.eksvpc_cidr

  azs                     = data.aws_availability_zones.azs.names
  public_subnets          = var.ekspub-subnet
  private_subnets         = var.ekspriv-subnet
  
  enable_dns_hostnames    = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_support      = true   

  

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1

  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/private_elb"       = 1

  }
  
}

locals {
  cluster_name="my-eks-cluster"
}


#EKS

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true
  enable_irsa = true
   
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

authentication_mode = "API_AND_CONFIG_MAP"

eks_managed_node_group_defaults = {
    
    instance_types = var.instance_types
    ami_type= "AL2_x86_64"
    vpc_security_group_ids= [aws_security_group.all_worker.id]
    
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
          
    }
  }
   tags = {
    Environment = "dev"
    Terraform   = "true"
    Name= "eks_demo"
  }
}
  
  /* 
  eks_managed_node_groups = {
    eksnodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      security_group_id = [aws_security_group.all_worker.id]

      instance_types = var.instance_types
            
    }
    
  }

 

data "aws_eks_cluster" "cluster" {
  name=module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name=module.eks.cluster_id
}
 */
