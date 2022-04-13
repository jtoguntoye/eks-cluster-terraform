data "aws_availability_zones" "available_azs" {
    state = "available"
}

# used for accessing Account ID and ARN
data "aws_caller_identity" "current" {}