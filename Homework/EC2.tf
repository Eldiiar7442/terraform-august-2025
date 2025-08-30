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

resource "aws_instance" "test" {
  ami           = data.aws_ami.ubuntu.id # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  associate_public_ip_address = true 
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.original1.id
  user_data = file("apache.sh") 
}

resource "aws_key_pair" "deployer" {
  key_name   = "my-eldi-key"                    # имя ключа в AWS
  public_key = file("/home/ec2-user/.ssh/id_ed25519.pub")  # полный путь к публичному ключу на этом EC2
}
