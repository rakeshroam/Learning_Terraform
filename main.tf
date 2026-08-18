data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-debian-12-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["612051870749"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.nano"

  # Add these for production use:
  # subnet_id              = aws_subnet.main.id
  # vpc_security_group_ids = [aws_security_group.web.id]
  # key_name               = "your-key-pair"

  tags = {
    Name = "HelloWorld"
  }
}

