module "ec2-gb-runner" {
  source       = "./ec2-gb-runner"
  gitlab_token = var.gitlab_token
  runners      = 2
}
