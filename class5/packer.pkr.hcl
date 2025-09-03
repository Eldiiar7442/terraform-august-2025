packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "exemple" {
  ami_name      = "Golden-Image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-00ca32bbc84273381"
  ssh_username = "ec2-user"
  ssh_keypair_name = "packer"
  ssh_private_key_file = "/home/ec2-user/.ssh/id_ed25519"

  ami_users = ["205922932953"]

  ami_regions = ["us-east-1"]
  
  run_tags = {
    Name = "Golden Image"
  }
}

build {
    sources = ["source.amazon-ebs.exemple"]

    provisioner "shell" {
        script = "setup.sh"

    }

    provisioner "breakpoint" {
        note = "Please verify"

    }
}

