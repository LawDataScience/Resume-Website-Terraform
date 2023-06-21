resource "aws_launch_template" "website_app"{
    name = "website_app"
    image_id = "ami-053b0d53c279acc90"
    key_name = "ec2keypair"
    vpc_security_group_ids = [aws_security_group.website_app.id]
}