resource "aws_security_group" "sg_webserver" {
    name = "${var.unique_name} SG for Webserver"
    vpc_id = var.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [var.sg_elb_id]
    }

    egress {
        to_port     = 0
        from_port   = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.unique_name}-sg_webserver"
    }
}