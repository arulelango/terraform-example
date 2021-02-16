
resource "aws_iam_role" "iam_for_input_processor_lambda" {
  name = "iam_for_input_processor_lambda"

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

# S3 bucket notification
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.input_processor.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "${var.s3_input_bucket_arn}"
}

data "archive_file" "archive" {
  type        = "zip"
  output_path = "./${var.input_processor_archive_name}.zip"
  source_dir  = "${var.input_processor_source_dir}"
}

resource "aws_lambda_function" "input_processor" {
  filename      = "${var.input_processor_archive_name}.zip"
  function_name = "input-processor"
  description   = "My simple lambda function"
  role          = aws_iam_role.iam_for_input_processor_lambda.arn
  handler       = "importcsv.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
    role       = aws_iam_role.iam_for_input_processor_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}