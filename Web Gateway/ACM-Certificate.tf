/*
resource "aws_acm_certificate" "website_api"{
    domain_name = "lawdatascience.org"
    validation_method = "DNS"
}

data "aws_route53_zone" "public_website"{
    name = "lawdatascience.org"
    private_zone = false
}

resource "aws_route53_record" "website_api_validation"{
    zone_id = "${data.aws_route53_zone.public_website.zone_id}"
    for_each = {
        for dvo in aws_acm_certificate.website_api.domain_validation_options : dvo.domain_name => {
            name = dvo.resource_record_name
            record = dvo.resource_record_value
            type = dvo.resource_record_type
        }
    }
    allow_overwrite = true
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
    # zone_id = data.aws_route53_zone.public_website.zone_id
}

resource "aws_acm_certificate_validation" "website_api"{
    certificate_arn = aws_acm_certificate.website_api.arn
    validation_record_fqdns = [for record in aws_route53_record.website_api_validation : record.first]
}*/