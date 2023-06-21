# EC2 Instance Implementation
resource "aws_instance" "first"{
    # Set up to run Ubuntu
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = "ec2keypair"
    /* decided against using the ELB at this time, but didn't want to get rid of it in case
     I decided to implement it at a later date if demand on the site is too high for one EC2 instance to handle.
     I might also look into ECS/ECR if this problem arises. However implementing the already designed 
    ELB would be faster in the short term and allow me to keep the website up while I develop the ECS/ECR Implementation*/
    # security_groups = ["elb-sg"]
    user_data = <<EOF
    #!/bin/bash
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    echo "This is a web server" > /var/www/html/index.html
    EOF
    tags = {
        Name = "webserver"
        source = "terraform"
    }
}
/*
Second EC2 Instance Implementation, will be applied with the ELB if 
traffic is too large for one EC2 instance to handle.
resource "aws_instance" "second"{
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = "ec2keypair"
    security_groups = ["elb-sg"]
    user_data = <<EOF
    #!/bin/bash
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    echo "This is a web server" > /var/www/html/index.html
    EOF
    tags = {
        Name = "webserver"
        source = "terraform"
    }
}
*/