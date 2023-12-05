resource "aws_iam_role" "role-lambda-jolly-doctors" {
  name               = "role-lambda-jolly-doctors"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-attach-basic" {
  role       = aws_iam_role.role-lambda-jolly-doctors.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "index" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/jolly.zip"
}

resource "aws_lambda_function" "lambda-jolly-doctors" {
  filename = "${path.module}/jolly.zip"
  function_name = "jolly"
  role    = aws_iam_role.role-lambda-jolly-doctors.arn
  handler = "index.handler"
  runtime = "nodejs12.x"
  source_code_hash = "${data.archive_file.index.output_base64sha256}"
  timeout = 30
  memory_size = 128
}


resource "aws_iam_role_policy" "policy-lambda-jolly-doctors" {
  name = "lambda-jolly-doctors"
  role = aws_iam_role.role-lambda-jolly-doctors.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DynamoDBIndexAndStreamAccess",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": [
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-doctors",
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-doctors/index/*",
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-patients",
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-patients/index/*",
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-appointments",
              "arn:aws:dynamodb:us-east-1:030572408009:table/jolly-appointments/index/*",



              
            ]
        }
    ]
})
}
