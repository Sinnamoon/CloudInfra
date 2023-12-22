# Ici on créé les Security Groups pour la base de données RDS, pour le bastion et pour l'application
# On utilise un Security Group pour la base de données RDS qui autorise les connexions depuis le Security Group de l'application et depuis le Security Group du bastion
# Ici on créé les Security Groups pour la base de données RDS, pour le bastion et pour l'application
# On utilise un Security Group pour la base de données RDS qui autorise les connexions depuis le Security Group de l'application et depuis le Security Group du bastion

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_rds.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

  resource "aws_security_group" "allow_http_https_tcp" {
    name        = "allow_http_https_tcp"
    description = "Allow HTTP, HTTPS et TCP inbound traffic"
    vpc_id      = aws_vpc.vpc_rds.id

    ingress {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
