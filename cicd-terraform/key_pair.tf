resource "aws_key_pair" "cicd_key" {
  key_name   = var.key_name
  public_key = file("jenkins-key.pub")
}

