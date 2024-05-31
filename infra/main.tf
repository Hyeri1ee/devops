resource "aws_vpc" "nameVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "nameVPC"
  }
}
#4 subnets (web-subneta1,web-subnetb1 - frontend , was-subneta2,was-subnetb2 - backend)
resource "aws_subnet" "web-subneta1" {

  vpc_id                  = aws_vpc.nameVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "web-subneta1"
  }
}
resource "aws_subnet" "was-subneta2" {

  vpc_id                  = aws_vpc.nameVPC.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "was-subneta2"
  }
}
resource "aws_subnet" "web-subnetb1" {

  vpc_id                  = aws_vpc.nameVPC.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "web-subnetb1"
  }
}
resource "aws_subnet" "was-subnetb2" {

  vpc_id                  = aws_vpc.nameVPC.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "was-subnetb2"
  }
}
#internet gateway
resource "aws_internet_gateway" "Name_gw" {
  vpc_id = aws_vpc.nameVPC.id
  tags = {
    Name = "NameInternetGateway"
  }
}
#route table (web-routingtable , was-routingtable)
resource "aws_route_table" "web-routingtable" {
  vpc_id = aws_vpc.nameVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Name_gw.id
  }
  tags = {
    Name = "web-routingtable"
  }
}
resource "aws_route_table" "was-routingtable" {
  vpc_id = aws_vpc.nameVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Name_gw.id
  }
  tags = {
    Name = "was-routingtable"
  }
}
#routing table association (web-routeasso, was-routeasso)
resource "aws_route_table_association" "web-routeasso1" {

  subnet_id      = aws_subnet.web-subneta1.id
  route_table_id = aws_route_table.web-routingtable.id
}
resource "aws_route_table_association" "web-routeasso2" {

  subnet_id      = aws_subnet.web-subnetb1.id
  route_table_id = aws_route_table.web-routingtable.id
}
resource "aws_route_table_association" "was-routeasso3" {

  subnet_id      = aws_subnet.was-subneta2.id
  route_table_id = aws_route_table.was-routingtable.id
}
resource "aws_route_table_association" "was-routeasso4" {

  subnet_id      = aws_subnet.was-subnetb2.id
  route_table_id = aws_route_table.was-routingtable.id
}
#security group (web-sg, was-sg, mariadb-sg)
resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "web security group"
  vpc_id      = aws_vpc.nameVPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "was-sg" {
  name        = "was-sg"
  description = "was security group"
  vpc_id      = aws_vpc.nameVPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4040
    to_port     = 4040
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "mariadb-sg" {
  name        = "mariadb-sg"
  description = "mariadb security group"
  vpc_id      = aws_vpc.nameVPC.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#instance(web1,web2,was1,was2)
resource "aws_instance" "web1" {
  ami      = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name      = "awsubuntu"
  subnet_id     = aws_subnet.web-subneta1.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.web-sg.id]

  user_data = base64encode(file("user_data.sh"))
  tags = {
    Name = "web1"
  }
}
resource "aws_instance" "web2" {
  ami      = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name      = "awsubuntu"
  subnet_id     = aws_subnet.web-subnetb1.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.web-sg.id]

  user_data = base64encode(file("user_data.sh"))
  tags = {
    Name = "web2"
  }
}
resource "aws_instance" "was1" {
  ami      = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name      = "awsubuntu"
  subnet_id     = aws_subnet.was-subneta2.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.was-sg.id]

  user_data = base64encode(file("user_data.sh"))
  tags = {
    Name = "was1"
  }
}
resource "aws_instance" "was2" {
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  key_name                    = "awsubuntu"
  subnet_id                   = aws_subnet.was-subnetb2.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.was-sg.id]

  user_data = base64encode(file("user_data.sh"))
  tags      = {
    Name = "was2"
  }
}