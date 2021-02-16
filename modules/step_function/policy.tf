# resource "aws_iam_policy" "cloud_watch_logs_policy" {
#   name = "cloud-watch-logs-policy"
#   description = "Allowing cloudwatch logs for Step functions"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#          "Effect":"Allow",
#          "Action":[
#             "logs:CreateLogDelivery",
#             "logs:GetLogDelivery",
#             "logs:UpdateLogDelivery",
#             "logs:DeleteLogDelivery",
#             "logs:ListLogDeliveries",
#             "logs:PutResourcePolicy",
#             "logs:DescribeResourcePolicies",
#             "logs:DescribeLogGroups"
#          ],
#          "Resource": [
#              "*"
#          ]
#       }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy" "xray_access_policy" {
#   name = "xray_access_policy"
#   description = "Allowing xray thread for Step functions"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#          "Effect":"Allow",
#          "Action":[
#             "xray:PutTraceSegments",
#             "xray:PutTelemetryRecords",
#             "xray:GetSamplingRules",
#             "xray:GetSamplingTargets"
#          ],
#          "Resource": [
#              "*"
#          ]
#       }
#   ]
# }
# EOF
# }

# # resource "aws_iam_role_policy_attachment" "s3_get_policy" {
# #     role       = "${var.iam_for_lambda_name}"
# #     policy_arn = aws_iam_policy.s3_policy.arn
# # }

# resource "aws_iam_role_policy_attachment" "step_cloud_watch_policy_attach" {
#     role       = module.step_function.this_role_name
#     policy_arn = aws_iam_policy.cloud_watch_logs_policy.arn
# }

