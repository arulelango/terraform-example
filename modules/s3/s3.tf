resource "aws_s3_bucket" "bucket" {
  bucket = "${var.input_bucket_name}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    # lambda_function_arn = aws_lambda_function.func.arn
    lambda_function_arn = "${var.input_lambda_id}"
    events              = ["s3:ObjectCreated:*"]
    # filter_prefix       = "AWSLogs/"
    # filter_suffix       = ".log"
  }

  # depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_iam_policy" "s3_policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
         "Effect":"Allow",
         "Action":[
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:DeleteObject"
         ],
         "Resource":"arn:aws:s3:::arul9999999-input-bucket/*"
      }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "logs_policy" {
    # role       = aws_iam_role.iam_for_lambda.name
    role       = "${var.iam_for_lambda_name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "s3_get_policy" {
    role       = "${var.iam_for_lambda_name}"
    policy_arn = aws_iam_policy.s3_policy.arn
}