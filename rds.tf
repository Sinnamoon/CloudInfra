#resource "aws_db_subnet_group" "default" {
#  name       = "main"
#  subnet_ids = [aws_subnet.private_subnet_rds.id]
#
#  tags = {
#    Name = "My DB subnet group"
#  }
#}

resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = [
    aws_subnet.public_subnet_rds.id,
    aws_subnet.private_subnet_rds.id,
    aws_subnet.public_subnet_rds_b.id,
    aws_subnet.private_subnet_rds_b.id,
  ]
}

resource "aws_db_instance" "notdefault" {
  allocated_storage    = 10
  db_name              = "infrasql"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "joan"
  password             = "BingBonhg123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
}