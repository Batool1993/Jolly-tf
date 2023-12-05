resource "aws_dynamodb_table" "jolly-doctors" {
  name           = "jolly-doctors"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  # partition key
  hash_key       = "id"
  # sort key
  # range_key      = "name"

  attribute {
    name = "id"
    type = "S"
  }
  # attribute {
  #   name = "name"
  #   type = "S"
  # }
}

resource "aws_dynamodb_table" "jolly-patients" {
  name           = "jolly-patients"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  # partition key
  hash_key       = "id"
  # sort key
  # range_key      = "name"

  attribute {
    name = "id"
    type = "S"
  }
  # attribute {
  #   name = "name"
  #   type = "S"
  # }
}

resource "aws_dynamodb_table" "jolly-appointments" {
  name           = "jolly-appointments"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  # partition key
  hash_key       = "id"
  # sort key
  # range_key      = "name"

  attribute {
    name = "id"
    type = "S"
  }
  # attribute {
  #   name = "name"
  #   type = "S"
  # }
}

resource "aws_dynamodb_table" "jolly-callLogs" {
  name           = "jolly-callLogs"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  # partition key
  hash_key       = "id"
  # sort key
  # range_key      = "name"

  attribute {
    name = "id"
    type = "S"
  }
  # attribute {
  #   name = "name"
  #   type = "S"
  # }
}
