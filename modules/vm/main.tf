resource "aws_instance" "example_vm" {
  ami           = "${var.ami}"
  instance_type = "${var.instancetype}"
  tags = {
      Name = "${var.vmname}"
  }
}