terraform {
    required_version = "1.15.8"
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = " >=6.28.0"
        }
    }
}

terraform {
  backend "s3" {
    bucket = "terraformbackup-167251111434-ap-south-1-an"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}