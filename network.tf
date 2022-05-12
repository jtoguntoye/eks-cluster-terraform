# Elastic IP to be used by the NAT Gateway
resource "aws_eip" "nat_gw_elastic_ip" {
    vpc         = true
    tags        = {
    Name        = "${var.cluster_name}-nat-eip"
    Environment = var.iac_environment_tag
    } 
 }

 module "vpc" {
     source          = "terraform-aws-modules/vpc/aws"

     name            = "${var.cluster_name}-vpc"
     cidr            = var.main_vpc_cidr
     azs             =  data.aws_availability_zones.available_azs.names  
     private_subnets = [
         for zone_id in data.aws_availability_zones.available_azs.zone_ids : 
         cidrsubnet(var.main_vpc_cidr, var.subnet_prefix_extension, tonumber(substr(zone_id,length(zone_id)-1, 1)) - 1) 
     ]

     public_subnets = [
         for zone_id in data.aws_availability_zones.available_azs.zone_ids :
          cidrsubnet(var.main_vpc_cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id)-1, 1)) + var.zone_offset -1)
     ]

     enable_nat_gateway            =  true
     single_nat_gateway            = true
     one_nat_gateway_per_az        = false
     enable_dns_hostnames  = true
     enable_dns_support = true
     reuse_nat_ips                 = true
     external_nat_ip_ids           = [aws_eip.nat_gw_elastic_ip.id]

     #Add vpc and subnet tags required by EKS
     tags = {
     "kubernetes.io/cluster/${var.cluster_name}" = "shared"
     iac_environment                             = var.iac_environment_tag
     }

    public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
    iac_environment                             = var.iac_environment_tag

    }
    private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    iac_environment                             = var.iac_environment_tag
     }


 }