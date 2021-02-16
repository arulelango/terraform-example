
resource "aws_iam_role" "iam_for_equifax_lambda" {
  name = "iam_for_equifax_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

data "archive_file" "archive" {
  type        = "zip"
  output_path = "./${var.cra_equifax_lambda_archive_name}.zip"
  source_dir  = "${var.cra_equifax_lambda_source_dir}"
}

resource "aws_lambda_function" "cra_equifax" {
  filename      = "${var.cra_equifax_lambda_archive_name}.zip"
  function_name = "cra_equifax_func_lambda"
  description   = "Lambda that crates a db record"
  role          = aws_iam_role.iam_for_equifax_lambda.arn
  handler       = "equifax_processor.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
    role       = aws_iam_role.iam_for_equifax_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}