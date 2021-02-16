provider "aws" {
  region = "${var.region}"
}

module "s3" {
  source = "./../modules/s3"
  input_lambda_id = module.lambda.input_lambda_arn
  iam_for_lambda_name = module.lambda.iam_role_lambda_name
  input_bucket_name = "${var.bucket_name}"
}

module "lambda" {
  source = "./../modules/lambda"
  s3_bucket_arn = module.s3.input_s3_bucket_id
}
