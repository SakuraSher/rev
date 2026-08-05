terraform{
    required_version = ">= 1.15.3"
    backend "s3" {
        bucket = "terraformbackup-167251111434-ap-south-1-an"
        key = "day9/terraform.tfstate"
        use_lockfile = true
        region = "ap-south-1"
        encrypt = true
    }

    required_providers{
        aws ={
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
        //Add here
         random ={
            source = "hashicorp/random"
            version = "~> 3.6"
        }
    }
}