provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "SearchAppVpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "SearchAppVpc"
  }
}

resource "aws_subnet" "SearchAppSubnet1" {
  vpc_id                  = aws_vpc.SearchAppVpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "SearchAppSubnet1"
  }
}

resource "aws_subnet" "SearchAppSubnet2" {
  vpc_id                  = aws_vpc.SearchAppVpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "SearchAppSubnet2"
  }
}

resource "aws_internet_gateway" "SearchApp_gw" {
  vpc_id = aws_vpc.SearchAppVpc.id
  tags = {
    Name = "SearchAppInternetGateway"
  }
}

resource "aws_route_table" "SearchApp_rt" {
  vpc_id = aws_vpc.SearchAppVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SearchApp_gw.id
  }

  tags = {
    Name = "SearchAppRouteTable"
  }
}

resource "aws_route_table_association" "SearchApp_rta1" {
  subnet_id      = aws_subnet.SearchAppSubnet1.id
  route_table_id = aws_route_table.SearchApp_rt.id
}

resource "aws_route_table_association" "SearchApp_rta2" {
  subnet_id      = aws_subnet.SearchAppSubnet2.id
  route_table_id = aws_route_table.SearchApp_rt.id
}

resource "aws_security_group" "SearchApp_securitygroup" {
  name        = "SearchApp_securitygroup"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.SearchAppVpc.id

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
    from_port   = 3000
    to_port     = 3000
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

resource "aws_lb" "searchapp_alb" {
  name               = "searchapp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SearchApp_securitygroup.id]
  subnets            = [aws_subnet.SearchAppSubnet1.id, aws_subnet.SearchAppSubnet2.id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "searchapp_tg" {
  name     = "searchapp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.SearchAppVpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "searchapp_listener" {
  load_balancer_arn = aws_lb.searchapp_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.searchapp_tg.arn
  }
}

resource "aws_launch_configuration" "searchapp_lc" {
  name          = "searchapp-lc"
  image_id      = "ami-080e1f13689e07408"
  instance_type = "t2.large"
  key_name      = "awsubuntu"
  security_groups = [aws_security_group.SearchApp_securitygroup.id]

  user_data = base64encode(file("user_data.sh"))
}

resource "aws_autoscaling_group" "searchapp_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.SearchAppSubnet1.id, aws_subnet.SearchAppSubnet2.id]
  launch_configuration = aws_launch_configuration.searchapp_lc.name
  target_group_arns    = [aws_lb_target_group.searchapp_tg.arn]

  tag {
    key                 = "Name"
    value               = "SearchApp_instance"
    propagate_at_launch = true
  }
}

resource "aws_s3_bucket" "searchapp_bucket" {
  bucket = "searchapp-static-content"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
