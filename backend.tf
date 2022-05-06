provider "aws" {
    region = var.region
}

provider "random" {
}

# get EKS authentication for being able to manage k8s objects from terraform
provider "kubernetes" {
host                   = data.aws_eks_cluster.cluster.endpoint
cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
token                  = data.aws_eks_cluster_auth.cluster.token    
}

terraform {
  backend "s3" {
      bucket = "city-allies-site"
      key = "s3/terraform.tfstate"
      region = "eu-west-3"
  }
}