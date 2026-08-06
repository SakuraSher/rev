provider "aws"{
    region = "ap-south-1"
    default_tags {
        tags = {
            "cost-center" = "01234567890"
            "account" = "1234567891"
            "project" = "terraform"
        }
    }
}

provider "aws"{
    alias = "provider-us-east-2"
    region = "us-east-2"
}

