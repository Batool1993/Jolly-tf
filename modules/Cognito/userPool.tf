resource "aws_cognito_user_pool" "pool" {
  name                     = var.userpool_name
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
  username_attributes = ["email"]
  auto_verified_attributes = ["email"]
  email_verification_subject = "Your verification code"
  email_verification_message = "Your verification code is {####}."
    password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
  
}

resource "aws_cognito_user_pool_client" "client" {
  name = "jolly-HR"

  user_pool_id = var.userpool_id
}