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
  source = "./../modules/input_processor_lambda"
  s3_input_bucket_arn = module.s3.input_s3_bucket_id
}

module "input-db-lambda" {
  source = "./../modules/db_entry_lambda"
}

module "cra-equifax-lambda" {
  source = "./../modules/cra_equifax_lambda"
}

module "cra-gbg-lambda" {
  source = "./../modules/cra_gbg_lambda"
}

module "cleanup-lambda" {
  source = "./../modules/cleanup_lambda"
}


module "step_function" {
  source = "./../modules/step_function"
  # first_lambda_arn = module.lambda.input_lambda_arn
  db_lambda_arn = module.input-db-lambda.db_entry_lambda_arn
  equifax_lambda_arn = module.cra-equifax-lambda.cra_equifax_lambda_arn
  gbg_lambda_arn = module.cra-gbg-lambda.cra_gbg_lambda_arn
  cleanup_lambda_arn = module.cleanup-lambda.cleanup_lambda_arn
}
