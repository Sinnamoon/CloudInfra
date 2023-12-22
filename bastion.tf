# Ici on veut créer une instance EC2 qui servira de bastion pour se connecter à la base de données RDS
# On utilise une AMI Amazon Linux 2
# On utilise un Security Group qui autorise les connexions SSH depuis notre IP publique
# On utilise une clé SSH pour se connecter à l'instance
# On utilise un Elastic IP pour pouvoir se connecter à l'instance même si elle est recréée

resource "aws_instance" "ec2bastion" {
  ami = "ami-072a132dda549474e"
  instance_type = "t2.micro"
  key_name = "SUSSYKEYPAIR"
  subnet_id = aws_subnet.public_subnet_rds.id

  #must add SG (i do it manually)
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_http_https_tcp.id
  ]
  tags = {
    Name = "sussyBakaBastionEc2"
  }
}


resource "aws_eip" "bastion_eip" {
  instance = aws_instance.ec2bastion.id
}

output "bastion_private_ip" {
  value = aws_eip.bastion_eip.private_ip
}