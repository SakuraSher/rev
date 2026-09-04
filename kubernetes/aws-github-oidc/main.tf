#steps to create an OIDC provider

#register an OIDC provider
# Create an IAM role for it

resource "aws_iam_openid_connect_provider" "github_oidc"{
    url = "https://token.actions.githubusercontent.com"
    client_id_list = ["sts.amazonaws.com"] # this is the audience
    thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # this is the thumbprint of the OIDC provider
}