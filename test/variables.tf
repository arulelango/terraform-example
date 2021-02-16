variable "region" {  
    type = string
    default = "eu-west-2"
}

variable "archive_name" {
  type = string
  default = "python-code"
}

variable "source_dir" {
  type = string
  default = "./../src/lambda-function1/"
}
variable "bucket_name" {
  type = string
}
