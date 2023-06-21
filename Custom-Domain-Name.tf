resource "aws_apigatewayv2_domain_name" "website_api"{
    domain_name = "lawdatascience.org"
    domain_name_configuration {
        certificate_arn = aws_acm_certificate.website_api.arn
        endpoint_type = "REGIONAL"
        security_policy = "TLS_1_2"
    }
    depends_on = [aws_acm_certificate_validation.website_api]
}

resource "aws_route53_record" "website_api"{
    name = aws_apigatewayv2_domain_name.website_api.domain_name
    type = "A"
    zone_id = data.aws_route53_zone.public_website.zone_id
    alias {
        name = aws_apigatewayv2_domain_name.website_api.domain_name_configuration[0].target_domain_name
        zone_id = aws_apigatewayv2_domain_name.website_api.domain_name_configuration[0].hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_apigatewayv2_api_mapping" "website_api"{
    api_id = aws_apigatewayv2_api.website_app_gateway.id
    domain_name = aws_apigatewayv2_domain_name.website_api.id
    stage = aws_apigatewayv2_stage.dev.id
}

output "custom_domain_website_api"{
    value = "https://${aws_apigatewayv2_api_mapping.website_api.domain_name}/health"
}