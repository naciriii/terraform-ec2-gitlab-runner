output "ec2-runner-dns" {
  value       = aws_instance.ec2-gb-runner.public_dns
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-ip" {
  value       = aws_instance.ec2-gb-runner.public_ip
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-type" {
  value = aws_instance.ec2-gb-runner.instance_type
}
output "gitlab_token" {
  value = var.gitlab_token
}
