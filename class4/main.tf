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
  availability_zone = "us-east-2a" 
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
}

resource "aws_key_pair" "deployer" {
  key_name   = "new-deployer-key"                       # имя ключа в AWS
  public_key = file("/home/ec2-user/.ssh/id_ed25519.pub")  # полный путь к публичному ключу на этом EC2
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

  
}
resource "null_resource" "cluster" {
  
  triggers = {
    always_run = "${timestamp()}"
  }


  connection {
    host = element(aws_instance.test.*.public_ip, 0)
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/ec2-user/.ssh/id_ed25519") 
  }

  provisioner "remote-exec" {
  inline = [
    "sudo apt-get update -y",
    "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y",
    "sudo apt-get install -y apache2"
  ]
}

}