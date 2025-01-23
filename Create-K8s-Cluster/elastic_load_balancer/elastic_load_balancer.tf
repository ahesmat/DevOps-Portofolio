# Elastic Load Balancer (ALB) in Public Subnet 2 (us-east-1b)
resource "aws_lb" "ha_cluster_alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.elb_sg] # Reference the existing security group
  subnets            = [var.subnet_1, var.subnet_2,var.subnet_3]

  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

# Target Group for the ALB
resource "aws_lb_target_group" "ha_cluster_target_group" {
  name     = var.tg_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

   dynamic "health_check" {
     for_each = var.protocol == "HTTPS" ? [1] : []
  content {

    path                = var.path
    port                = var.port
    protocol            = var.protocol
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3

       }
     }
  tags = {
    Name = var.tg_name
  }
}


output "target_group_arn" {
    value = aws_lb_target_group.ha_cluster_target_group.arn
  }


output "lb_dns_name" {
  value = aws_lb.ha_cluster_alb.dns_name
}

output "lb_zone_id" {
  value = aws_lb.ha_cluster_alb.zone_id
}

output "lb_arn" {
  value = aws_lb.ha_cluster_alb.arn
}
