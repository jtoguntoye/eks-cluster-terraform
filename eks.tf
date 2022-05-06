module "eks_cluster" {
    source           = "terraform-aws-modules/eks/aws"
    cluster_name     = "${var.cluster_name}"
    version          = "17.1.0"
    cluster_version  = "1.20"
    write_kubeconfig = true

    subnets =  module.vpc.private_subnets
    vpc_id = module.vpc.vpc_id
    
    worker_groups_launch_template = local.worker_groups_launch_template

    #map developer and admin ARNs as Kubernetes users
    map_users = concat(local.admin_user_map_users, local.developer_user_map_users)  
}