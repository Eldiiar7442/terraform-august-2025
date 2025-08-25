resource "aws_key_pair" "deployer" {
  key_name   = "new-deployer-key"
  public_key = file("~/.ssh/new-deployer-key.pub")
}
