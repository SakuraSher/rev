data "aws_ecr_repository" "ecrrepo" {
  name = "bootcamp/day8"
}

output "ecr_repo_url" {
  value = data.aws_ecr_repository.ecrrepo.repository_url
}
# resource "aws_ecr_repository" "ecrrepo" {
#   name                 = "bootcamp/day8"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }