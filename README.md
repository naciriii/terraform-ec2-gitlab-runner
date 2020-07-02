[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)


# EC2 Gitlab Runner

This repository holds the terraform description of reusable scalable gitlab runner hosted on t2.micro AWS EC2.

The Gitlab runner is hosted on EC2 Instance  and parametrized as needed and make use from the free tier at maximum.


##  Structure

| **Root Directory** ||
|------ |--- |

|main.tf |EC2 machines intialization and configuration along with configuring security groups and ebs volumes |
|output.tf |Here we specify the output of the module after applying changes) | 
|vars.tf |Here we declare and initialize variables used by the ec2-gb-runner module) |
|scripts | Initialization script to be executed in provisioned ec2 instances on launch through cloud-init ec2 user-data, init.tpl will execute a bash script that handles installing docker and gitlab runner and registering runners with gitlab projects/groups|



## Getting Started

-  make sure you have terraform installed (www.terraform.io)
-  Make Sure to have AWS credentials and set profile in ~/.aws/config and ~/.aws/credentials
-  for changes in the Repo:
  * go to <root>
  * Initialize with provider.tf and backend.tf as needed and set AWS as provider
  * Initialize the module in your main.tf as mentionned in the next section.
  * run `terraform init`
  * run `terraform plan` to make sure nothing unwanted changed
  * do changes
  * run `terraform plan`, make sure it's OK, 
  * run `terraform apply`
## Module Initialization
- Module initialization
```terraform
module "ec2-gb-runner" {
  source       = "github.com/naciriii/terraform-ec2-gitlab-runner"
  gitlab_token = <Gitlab project or group token>
  key_name = <EC2 Key name on AWS>
  allow-ssh = <True|False Allow SSH access to the ec2 instance, default(true)>
  runners      = <Number ofrunners to register, default(1)>
  concurrent = <Maximum number of concurrent executing jobs, default(10)>
  runner_url = <Gitlab runner coordinator url in case gitlab hosted in yoru server, default(https://gitlab.com)>
  runner_executor = <docker>
  runner_default_image = <Default image in the runner, default(ruby:2.5)>
  runner_name = <Runner name, default(ec2-gitlab-runner)>
  runner_tags = <Runner tags seperated by ',', default(ec2-gitlab-runner)>
  runner_locked = <Either runner is locked to the project or not, default(false)>
  runner_run_untagged = <Either runner is allowed to run untagged jobs, default(true)>
}
```
  
## Gitflow

* **Production branch:** `master`
* **Development branch:** `dev`
* **Feature prefix:** `feature/`
* **Hotfix prefix:** `hotfix/`

## More information

* [Terraform](www.terraform.io)
* [AWS Spot Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)
* [Autoscaling GitLab Runner on AWS EC2](https://docs.gitlab.com/runner/configuration/runner_autoscale_aws/)
* [Configuring GitLab CI on AWS EC2 Using Docker](https://hackernoon.com/configuring-gitlab-ci-on-aws-ec2-using-docker-7c359d513a46)
* [Manage Terraform With GitLab CI](https://medium.com/@dbourgeois23/manage-terraform-with-gitlab-ci-5c24005eb62a)
* [GitLab CI: Deployment & Environments](https://about.gitlab.com/blog/2016/08/26/ci-deployment-and-environments/)

