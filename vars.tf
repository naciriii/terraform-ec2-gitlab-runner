variable "gitlab_token" {
  description = "Gitlab ci token"
}
variable "profile" {
  description = "AWS profile"
  default     = "lc1"
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "tf-bucket" {
  description = "Terraform s3 bucket"
  default     = "tf-gitlab-ci-runner"
}
variable "tf-state-file" {
  description = "Terraform s3 remote state file"
  default     = "terraform.tfstate"
}