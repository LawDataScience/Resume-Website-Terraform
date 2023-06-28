/*

resource "aws_autoscaling_group" "website_app"{
    name = "website_app"
    min_size = 1
    max_size = 3
    health_check_type = "EC2"
    vpc_zone_identifier = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
    target_group_arns = [aws_lb_target_group.website_app.arn]
    mixed_instances_policy {
        launch_template{
            launch_template_specification{
                launch_template_id = aws_launch_template.website_app.id
            }
            override{
                instance_type = "t2.micro"
            }
        }
    }
}

resource "aws_autoscaling_policy" "website_app"{
    name = "website_app"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = aws_autoscaling_group.website_app.name
    estimated_instance_warmup = 300
    target_tracking_configuration{
        predefined_metric_specification{
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 25.0
    }
}*/