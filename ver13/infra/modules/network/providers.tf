provider "aws" {
    region = var.aws_region
    default_tags {
        tags = {
          "awsregion" = var.aws_region
        }

    }
  
}