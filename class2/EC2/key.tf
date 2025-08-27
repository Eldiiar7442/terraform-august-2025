resource "aws_key_pair" "deployer" {
  key_name   = "new-deployer-key"                       # имя ключа в AWS
  public_key = file("/home/ec2-user/.ssh/id_ed25519.pub")  # полный путь к публичному ключу на этом EC2

  tags = local.common_tags
}

output ec2  {
  value       = aws_instance.test.public_ip
}
