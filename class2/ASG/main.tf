data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Пример подсетей (если у тебя уже есть свои — используй их ID)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_vpc" "default" {
  default = true
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  name = "example-asg"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  vpc_zone_identifier = data.aws_subnets.default.ids

  # Новый LT создастся автоматически в us-east-1
  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  ebs_optimized     = true
  enable_monitoring = true
}
