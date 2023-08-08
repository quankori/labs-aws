resource "aws_route53_zone" "prj_r53_hz_dev" {
  name          = var.project_domain
  comment       = "Project testing hostzone"
  force_destroy = false
  tags = {
     Name = "${var.project_name}-r53-hz-${var.project_env}"
  }
}
