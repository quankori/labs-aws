resource "aws_acm_certificate" "prj_acm_dev" {
  provider                  = aws.us-east-1
  domain_name               = var.project_domain
  subject_alternative_names = ["*.${var.project_domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "prj_acm_southeast_dev" {
  domain_name               = var.project_domain
  subject_alternative_names = ["*.${var.project_domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "prj_acm_dev_domain" {
  value = aws_acm_certificate.prj_acm_dev.domain_name
}

output "prj_acm_dev_arn" {
  value = aws_acm_certificate.prj_acm_dev.arn
}
