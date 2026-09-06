provider "aws" {
    region = var.region
    default_tags {
        tags = {
            Environment = var.environment
            repo = "kubernetes"
        }
    }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}