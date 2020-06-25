
resource "aws_instance" "ec2-gb-runner" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  key_name      = "nacer"
  tags = {
    Name = "ec2-gitlab-runner"
  }
  user_data = data.template_file.init.rendered
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

}
resource "aws_security_group" "allow_ssh" {
  name        = "Allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}
data "template_file" "init" {
  template = file("${path.module}/scripts/init.tpl")
  vars = {
    gitlab_token = "${var.gitlab_token}"

  }
}