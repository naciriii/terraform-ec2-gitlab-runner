terraform {
  backend "s3" {
    bucket = var.tf-bucket
    key    = var.tf-state-file
    profile = var.profile
    region = var.region
  }
}
data "terraform_remote_state" "gitlab-runner" {
  backend = "s3"
  config = {
    bucket = var.tf-bucket
    key    = var.tf-state-file
    profile = var.profile
    region = var.region
  }
}