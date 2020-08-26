.PHONY: prepare init validate format plan apply-changes

prepare:
	@echo "Prepare Terraform Project"
	@touch private.auto.tfvars
	@echo 'profile        = "AWS_PROFILE"' > private.auto.tfvars
	@echo 'region         = "AWS_REGION"' >> private.auto.tfvars
	@echo 'bucket         = "REMOTE_STATE_S3_BUCKET"' >> private.auto.tfvars
	@echo 'key            = "REMOTE_STATE_KEY"' >> private.auto.tfvars
	@echo 'ec2_key_name   = "EC2_KEY_NAME"' >> private.auto.tfvars
	@echo 'ec2_public_key = "EC2_RAW_PUBLIC_KEY"' >> private.auto.tfvars
	@echo 'gitlab_token   = "GITLAB_TOKEN"' >> private.auto.tfvars
	@echo "\e[32mPlease Update private.auto.tfvars !"
init:
	@echo "Initialize Terraform Project"
	 - @terraform init -backend-config=private.auto.tfvars
validate:
	@echo "Terraform Validate"
	 - @terraform validate
format:
	@echo "Terraform Format files"
	 - @terraform fmt -recursive
plan:
	@echo "Terraform Plan"
	 - @terraform plan
apply-changes:
	@echo "\033[0;31mUse with Consideration and Caution or DON'T !!"
	@echo "\033[1;33m Are you Sure Press CTRL+C to quit or ENTER to continue ?!!"
	- @read continue
	- terraform apply
	

   	





