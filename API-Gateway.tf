resource "aws_apigatewayv2_api" "website_app_gateway"{
    name = "website_app_gateway"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev"{
    api_id = aws_apigatewayv2_api.website_app_gateway.id
    name = "dev"
    auto_deploy = true
}

resource "aws_apigatewayv2_vpc_link" "website_app"{
    name = "website_app"
    security_group_ids = [aws_security_group.website_app.id]
    subnet_ids = [
        aws_subnet.private-us-east-1a.id,
        aws_subnet.private-us-east-1b.id
    ]

}

resource "aws_apigatewayv2_integration" "website_app_gateway"{
    api_id = aws_apigatewayv2_api.website_app_gateway.id
    integration_uri = aws_lb_listener.website_app.arn
    integration_type = "HTTP_PROXY"
    integration_method = "ANY"
    connection_type = "VPC_LINK"
    connection_id = aws_apigatewayv2_vpc_link.website_app.id
}

resource "aws_apigatewayv2_route" "website_app_gateway"{
    api_id = aws_apigatewayv2_api.website_app_gateway.id
    route_key = "ANY /{proxy+}"
    target = "integrations/${aws_apigatewayv2_integration.website_app_gateway.id}"
}

