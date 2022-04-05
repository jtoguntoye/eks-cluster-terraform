# Elastic IP to be used by the NAT Gateway
resource "aws_eip" "nat_gw_elastic_ip" {
    vpc  = true
    tags = {
    Name = "${var.cluster_name}-nat-eip"
    Environment = var.environment
    } 
 }