output "ec2-runner-dns" {
  value       = module.ec2-gb-runner.ec2-runner-dns
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-ip" {
  value       = module.ec2-gb-runner.ec2-runner-ip
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-type" {
  value = module.ec2-gb-runner.ec2-runner-type
}
output "gitlab_token" {
  value = module.ec2-gb-runner.gitlab_token
}
