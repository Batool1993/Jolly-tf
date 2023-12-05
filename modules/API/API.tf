resource "aws_api_gateway_rest_api" "rest-jolly-Admin" {
  name        = "rest-jolly-Admin"
   body = file("${path.module}/jolly.json")

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  }

  resource "aws_api_gateway_rest_api" "rest-jolly-Consultant" {
  name        = "rest-jolly-Consultant"
   body = file("${path.module}/jolly.json")

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  }

  resource "aws_api_gateway_rest_api" "rest-jolly-Client" {
  name        = "rest-jolly-Client"
   body = file("${path.module}/jolly.json")

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  }

    resource "aws_api_gateway_rest_api" "rest-jolly-employer" {
  name        = "rest-jolly-employer"
   body = file("${path.module}/jolly.json")

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  }

  

# Deployment
resource "aws_api_gateway_deployment" "rest-jolly-Admin" {
  rest_api_id = aws_api_gateway_rest_api.rest-jolly-Admin.id

  lifecycle {
    create_before_destroy = true
  }
}

# Deployment
resource "aws_api_gateway_deployment" "rest-jolly-Consultant" {
  rest_api_id = aws_api_gateway_rest_api.rest-jolly-Consultant.id

  lifecycle {
    create_before_destroy = true
  }
}

# Deployment
resource "aws_api_gateway_deployment" "rest-jolly-Client" {
  rest_api_id = aws_api_gateway_rest_api.rest-jolly-Client.id

  lifecycle {
    create_before_destroy = true
  }
}

# Deployment
resource "aws_api_gateway_deployment" "rest-jolly-employer" {
  rest_api_id = aws_api_gateway_rest_api.rest-jolly-employer.id

  lifecycle {
    create_before_destroy = true
  }
}

# Stage
  resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.rest-jolly-Admin.id
  rest_api_id   = aws_api_gateway_rest_api.rest-jolly-Admin.id
  stage_name    = "dev"
}
