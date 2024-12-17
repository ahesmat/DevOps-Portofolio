resource "aws_lb_target_group_attachment" "worker_node_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = var.worker_node_id
  port             = 80
}

