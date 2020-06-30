
variable "gitlab_token" {
  description = "Gitlab ci token"
}
variable "runners" {
  description = "Number of runners to register"
  default     = 1
}
variable "runner_url" {
  description = "Gitlab runner Coordinator url"
  default     = "https://gitlab.com/"
}
variable "runner_executor" {
  description = "Gitlab runner executor ,"
  default     = "docker"
}
variable "runner_default_image" {
  description = "Docker executor default image"
  default     = "ruby:2.5"
}
variable "runner_name" {
  description = "Gitlab runner name"
  default     = "ec2-gitlab-runner"
}
variable "runner_tags" {
  description = "Gitlab runner tags seperated by ,"
  default     = "ec2-gitlab-runner"
}
variable "runner_locked" {
  description = "runner locked to projects or can be used by others"
  default     = false
}
variable "runner_run_untagged" {
  description = "runner can be used without tags in ci"
  default     = true
}
variable "concurrent" {
  description = "How many jobs allowed to run concurrently"
  default     = 4
}
