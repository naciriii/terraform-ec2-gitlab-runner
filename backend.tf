
terraform {
  backend "s3" {
    bucket  = "tf-gitlab-ci-runner"
    key     = "terraform.tfstate"
    profile = "lc1"
    region  = "us-east-1"
  }
}
data "terraform_remote_state" "gitlab-runner" {
  backend = "s3"
  config = {
    bucket  = var.tf-bucket
    key     = var.tf-state-file
    profile = var.profile
    region  = var.region
  }
}