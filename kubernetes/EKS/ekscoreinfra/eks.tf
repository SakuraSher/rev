module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "~>21.0"

    name = "${var.environment}-${var.vpc_name}"
    kubernetes_version = "1.34"

    endpoint_public_access = true
    enable_cluster_creator_admin_permissions = true
    addons = {
        coredns = {}
        eks-pod-identity-agent = {
      before_compute = true
    }
        vpc-cni = {
            before_compute = true
        }
        kube-proxy = {}
    }

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    #control_plane_subnet_ids = module.vpc.private_subnets

    #EKS Node Group Configuration
    eks_managed_node_groups = {
        node_group_1 = {
        ami_type = "AL2023_x86_64_STANDARD"
        instance_types = ["t3.medium"]
        max_size = 1
        desired_size = 1
        min_size = 1
    }
}
}