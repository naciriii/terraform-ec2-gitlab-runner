
resource "aws_instance" "ec2-gitlab-runner" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    Name = "ec2-gitlab-runner"
  }
  user_data = data.template_file.init.rendered
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  vpc_security_group_ids = [aws_security_group.gitlab_runner_security_group.id]

}
resource "aws_security_group" "gitlab_runner_security_group" {
  name        = "Gitlab_runner_security_group"
  description = "Gitlab runner security group with/without ssh ingress"
  dynamic "ingress" {
    for_each = var.allow-ssh ? [1] : []
    content {
      description = "SSH access from everywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "All Upstream Trafic Allowed"
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
    gitlab_token                = var.gitlab_token
    runners                     = var.runners
    concurrent_limit            = var.concurrent
    runner_url                  = var.runner_url
    runner_default_docker_image = var.runner_default_image
    runner_name                 = var.runner_name
    runner_executor             = var.runner_executor
    runner_tags                 = var.runner_tags
    runner_run_untagged         = var.runner_run_untagged
    runner_locked               = var.runner_locked





  }
}