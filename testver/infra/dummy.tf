

# resource "aws_instance" "my_ec2_instance" {
#   ami           = "ami-01a00762f46d584a1"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "MyEC2Instance"
#   }
# }



# resource "aws_instance" "my_ec2_instance1" {
#   ami           = "ami-0aa939abad20cdeae"
#   provider = aws.provider-us-east-2
#   instance_type = "t2.micro"
#   tags = {
#     Name = "MyEC2Instance"
#   }
# }