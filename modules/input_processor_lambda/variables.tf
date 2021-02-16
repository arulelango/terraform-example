variable "s3_input_bucket_arn" {
  type = string
}

variable "input_processor_archive_name" {
  type = string
  default = "input-processor-python-code"
}

variable "input_processor_source_dir" {
  type = string
  default = "./../src/cra-integration/input-processor/"
}