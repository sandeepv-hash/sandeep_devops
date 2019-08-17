resource "aws_instance" "test-inst" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"
  count         = "${var.count_instance}"
# vpc_id        = "${var.vpcid}" # Not required, subnet id will pick vpc_id
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"


depends_on = [aws_security_group.allow_tls]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"


  ingress {
    # TLS (change to whatever ports you need)
    from_port   = "443"
    to_port     = "443"
protocol = "tcp"
}

ingress {
    # TLS (change to whatever ports you need)
    from_port   = "22"
    to_port     = "22"
protocol = "tcp"
}


  egress {
    from_port       = "0"
    to_port         = "0"
protocol = "-1"
  }
}
