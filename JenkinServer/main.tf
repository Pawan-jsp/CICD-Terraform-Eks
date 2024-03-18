#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins_vpc"
  cidr = "10.0.0.0/16"

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    name = "Jenkis-subnet"

  }
}

#SG
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkin_sg"
  description = "Security group for Jenkins Server"
  vpc_id      = "module.vpc.vpc_id"

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "10.10.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "10.10.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    name = "jenkins_sg"
  }
}

#EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkis_server"

  instance_type               = "var.instance_type"
  ami                         = data.aws_ami.example.id
  key_name                    = "awsdevopskey"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.azs.names[0]
  user_data                   = file("jenki s-install.sh")
  tags = {
    name        = "Jenkins_server"
    Terraform   = "true"
    Environment = "dev"
  }
}