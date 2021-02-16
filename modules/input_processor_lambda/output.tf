output "input_lambda_arn" {
  value = "${aws_lambda_function.input_processor.arn}"
}

output "iam_role_lambda_name" {
  value = "${aws_iam_role.iam_for_input_processor_lambda.name}"
}