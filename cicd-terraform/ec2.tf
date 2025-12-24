resource "aws_instance" "jenkins" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.cicd_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = file("user_data_jenkins.sh")

  tags = {
    Name = "Jenkins-Ubuntu"
  }
}

