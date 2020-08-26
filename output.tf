output "ec2-runner-dns" {
  value       = aws_spot_instance_request.ec2-gitlab-runner.public_dns
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-ip" {
  value       = aws_spot_instance_request.ec2-gitlab-runner.public_ip
  description = "Ec2 gitlab runner public dns"
}
output "ec2-runner-ami" {
  value       = aws_spot_instance_request.ec2-gitlab-runner.ami
  description = "Ec2 gitlab runner AMI"
}
output "ec2-runner-os" {
  value       = data.aws_ami.ubuntu-server.name
  description = "Ec2 gitlab runner AMI"
}
output "ec2-runner-type" {
  value = aws_spot_instance_request.ec2-gitlab-runner.instance_type
}

