
resource "aws_iam_role" "iam_for_db_lambda" {
  name = "iam_for_db_lambda"

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
  output_path = "./${var.db_lambda_archive_name}.zip"
  source_dir  = "${var.db_lambda_source_dir}"
}

resource "aws_lambda_function" "db_entry" {
  filename      = "${var.db_lambda_archive_name}.zip"
  function_name = "entry_record_db_lambda"
  description   = "Lambda that crates a db record"
  role          = aws_iam_role.iam_for_db_lambda.arn
  handler       = "db_processor.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
    role       = aws_iam_role.iam_for_db_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}