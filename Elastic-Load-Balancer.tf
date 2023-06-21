
/*
    elastic load balancer security group
    resource "aws_security_group" "elb-sg"{
        name = "elb-sg"

        #incoming traffic
        ingress{
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        ingress{
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }

        #outgoing traffic
        egress{
            from_port = 0
            protocol = "-1"
            to_port = 0
            cidr_blocks = ["0.0.0.0/0"]
        }
}

    Elastic Load Balancer Implementation
    resource "aws_elb" "ram"{
        name = "ram-elb"
        availability_zones = ["us-east-1a", "us-east-1b"]

        listener {
            instance_port = 80
            instance_protocol = "http"
            lb_port = 80
            lb_protocol = "http"
        }
        health_check {
            healthy_threshold = 2
            unhealthy_threshold = 2
            timeout = 5
            target = "HTTP:80/"
            interval = 30
        }
        instances = ["${aws_instance.first.id}", "${aws_instance.second.id}"]
        cross_zone_load_balancing = true
        idle_timeout = 40
        tags = {
            Name = "demo-elb"
        }
    }
*/