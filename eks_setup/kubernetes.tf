
data "aws_eks_cluster" "cluster" {
  name= var.cluster_name
  depends_on = [ module.eks.cluster_name ]
  
}
data "aws_eks_cluster_auth" "cluster" {
  name= var.cluster_name
  depends_on = [ module.eks.cluster_name ]
  
}


provider "kubernetes" {
   host = data.aws_eks_cluster.my-eks-cluster.endpoint
   token= data.aws_eks_cluster_auth.my-eks-cluster.token
   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)

  
}
