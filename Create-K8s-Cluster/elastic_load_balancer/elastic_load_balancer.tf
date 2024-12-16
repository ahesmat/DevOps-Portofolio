# Elastic Load Balancer (ALB) in Public Subnet 2 (us-east-1b)
resource "aws_lb" "ha_cluster_alb" {
  name               = "ha-cluster-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.elb_sg] # Reference the existing security group
  subnets            = [var.public_subnet_1, var.public_subnet_2]

  enable_deletion_protection = false

  tags = {
    Name = "HA-Cluster-ALB"
  }
}

# Target Group for the ALB
resource "aws_lb_target_group" "ha_cluster_target_group" {
  name     = "ha-cluster-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "HA-Cluster-Target-Group"
  }
}

# ALB Listener
resource "aws_lb_listener" "ha_cluster_listener" {
  load_balancer_arn = aws_lb.ha_cluster_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ha_cluster_target_group.arn
  }
}

