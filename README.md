[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity) 


# EC2 Gitlab Runner

This repository holds the terraform description of reusable scalable gitlab runner hosted on t2.micro AWS EC2.

The Gitlab runner is hosted on EC2 spot instances in order to reduce costs and make use from the free tier at maximum (Spot instances can reduce ec2 costs almost to 90%), we make use of the unused Amazon EC2 cloud capacity based on spot instances requests, meanwhile if Amazon reclaim back the spot instance a new requests for another one will be created automatically through persistent spot requests to ensure availability of the runner's host.


##  Structure

| **Root Directory** ||
|------ |--- |
|main.tf|Initialization ofthe reusable ec2-gb-runner module to create as many as needed instances and set configuration variables in the initialization) |
|provider.tf |Here Set the provider to AWS |
|backend.tf|Here we initialize the s3 backend that store the state remotely, and expose the remote state to be used from s3|
|output.tf|Display what to output after applying changes) |
|       ***/ec2-gb-runner*** Directory | |
|main.tf |EC2 machines intialization and configuration along with configuring security groups and ebs volumes |
|output.tf |Here we specify the output of the module after applying changes) | 
|vars.tf |Here we declare and initialize variables used by the ec2-gb-runner module) |
|scripts | Initialization script to be executed in provisioned ec2 instances on launch through cloud-init ec2 user-data, init.tpl will execute a bash script that handles installing docker and gitlab runner and registering runners with gitlab projects/groups|



## Getting Started

-  make sure you have terraform installed (www.terraform.io)
-  Make Sure to have AWS credentials and set profile in ~/.aws/config and ~/.aws/credentials
- Make sure to have an s3 bucket and give your user needed policies.
-  for changes in the Repo:
### Manually
  * go to `<root>`
  * create a backend config file name it as you want
  * initialize AWS credentials in the file as below:
      ``` 
      profile        = "<AWS PROFILE>"
      region         = "<AWS REGION>"
      bucket         = "<REMOTE STATE BUCKET>"
      key            = "<REMOTE STATE FILE>"
      ```
  * run `terraform init --backend-config=your_config_file`
  * Initialize ec2-gitlab-runner module with needed variables as needed
  * run `terraform validate` to validate your changes
  * run `terraform fmt -recursive` to format files
  * run `terraform plan` to make sure nothing unwanted changed
  * do changes
  * run `terraform plan`, make sure it's OK, 
  * run `terraform apply` **Use with moderation**

### Makefile helpers
  * go to `<root>`
  * Run `make prepare` to prepare your terraform project and update private.auto.tfvars accordingly
  * run `make init` to initialize the project
  * run `make validate` to check if there are any validation errors
  * run `make format` to format your tf files
  * run `make plan` to confirm the remote changes
  * run `make apply-changes` to deploy your changes. **Use with moderation**


## Module Initialization
- Module initialization
```terraform
module "ec2-gb-runner" {
  source               = "github.com/naciriii/terraform-ec2-gitlab-runner"
  gitlab_token         = <Gitlab project or group token>
  instance_type        = <EC2 instance type, <default(t2.micro)>>
  key_name             = <EC2 Key name Optionally, default(null)>
  public_key           = <Public key passed inline to use to create EC2 key pair>
  runners              = <Number of runners to register, default(1)>
  concurrent           = <Maximum number of concurrent executing jobs, default(10)>
  runner_url           = <Gitlab runner coordinator url in case gitlab hosted in yoru server, default(https://gitlab.com)>
  runner_executor      = <docker>
  runner_default_image = <Default image in the runner, default(ruby:2.5)>
  runner_name          = <Runner name, default(ec2-gitlab-runner)>
  runner_tags          = <Runner tags seperated by ',', default(ec2-gitlab-runner)>
  runner_locked        = <Either runner is locked to the project/group or not, default(true)>
  runner_run_untagged  = <Either runner is allowed to run untagged jobs, default(true)>
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

