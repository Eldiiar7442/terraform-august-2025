resource "aws_key_pair" "deployer" {
  key_name   = var.key_name                     # имя ключа в AWS
  public_key = file(var.key_file)  # полный путь к публичному ключу на этом EC2
}
