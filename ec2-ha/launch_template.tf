resource "aws_launch_template" "launch_template" {
  name          = "${var.unique_name}-aws-launch-template"
  image_id      = data.aws_ami.amazon_linux_ami.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.sg_webserver.id]
  }
  user_data = base64encode(<<-EOT
              #!/bin/bash
              # Update system
              yum update -y

              # Install nginx
              amazon-linux-extras enable nginx1
              yum install -y nginx

              # Create simple index page
              echo "<h1>Hello from ${var.unique_name} instance - $(hostname)</h1>" > /usr/share/nginx/html/index.html

              # Enable and start nginx
              systemctl enable nginx
              systemctl start nginx
              EOT
  )

  block_device_mappings {
    device_name = "/dev/xvdb"
    ebs {
      volume_size           = 10
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/xvdc"
    ebs {
      volume_size           = 10
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  tags = {
    Name = "${var.unique_name}-lt"
  }
}