data "aws_caller_identity" "current" {}

module "aviatrix-iam-roles" {
  source = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-iam-roles?ref=terraform_0.12"
}

module "aviatrix-controller-build" {
  source  = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-build?ref=terraform_0.12"
  vpc     = aws_vpc.ob-eks-demo.id
  subnet  = aws_subnet.ob-eks-demo-public-alpha.id
  keypair = var.keypair
  ec2role = module.aviatrix-iam-roles.aviatrix-role-ec2-name
}

provider "aviatrix" {
  username      = "admin"
  password      = module.aviatrix-controller-build.private_ip
  controller_ip = module.aviatrix-controller-build.public_ip
}

module "aviatrix-controller-initialize" {
  source              = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-initialize?ref=terraform_0.12"
  admin_password      = var.admin_pw
  admin_email         = var.admin_email
  private_ip          = module.aviatrix-controller-build.private_ip 
  public_ip           = module.aviatrix-controller-build.public_ip
  access_account_name = var.aws_access_name
  aws_account_id      = data.aws_caller_identity.current.account_id
  vpc_id              = module.aviatrix-controller-build.vpc_id
  subnet_id           = module.aviatrix-controller-build.subnet_id
}

output "result" {
  value = module.aviatrix-controller-initialize.result
}

output "controller_private_ip" {
  value = module.aviatrix-controller-build.private_ip
}

output "controller_public_ip" {
  value = module.aviatrix-controller-build.public_ip
}