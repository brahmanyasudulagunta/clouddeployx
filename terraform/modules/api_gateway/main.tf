resource "aws_api_gateway_rest_api" "api" {

  name = "clouddeployx-api"
}

resource "aws_api_gateway_resource" "visitor" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  parent_id = aws_api_gateway_rest_api.api.root_resource_id

  path_part = "visitor"
}

resource "aws_api_gateway_method" "visitor_get" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  resource_id = aws_api_gateway_resource.visitor.id

  http_method = "GET"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "visitor" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  resource_id = aws_api_gateway_resource.visitor.id

  http_method = aws_api_gateway_method.visitor_get.http_method

  integration_http_method = "POST"

  type = "AWS_PROXY"

  uri = var.visitor_lambda_arn
}

resource "aws_api_gateway_resource" "contact" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  parent_id = aws_api_gateway_rest_api.api.root_resource_id

  path_part = "contact"
}

resource "aws_api_gateway_method" "contact_post" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  resource_id = aws_api_gateway_resource.contact.id

  http_method = "POST"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "contact" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  resource_id = aws_api_gateway_resource.contact.id

  http_method = aws_api_gateway_method.contact_post.http_method

  integration_http_method = "POST"

  type = "AWS_PROXY"

  uri = var.contact_lambda_arn
}

resource "aws_api_gateway_deployment" "deployment" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_integration.visitor,
    aws_api_gateway_integration.contact
  ]
}

resource "aws_api_gateway_stage" "dev" {

  deployment_id = aws_api_gateway_deployment.deployment.id

  rest_api_id = aws_api_gateway_rest_api.api.id

  stage_name = "dev"
}
