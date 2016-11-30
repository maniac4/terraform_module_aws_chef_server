output "aws_ec2_chef_server_id" { value = ["${aws_instance.chef-server.id}"] }
output "aws_ec2_chef_server_private_ip" { value = ["${aws_instance.chef-server.private_ip}"] }
output "aws_ec2_chef_server_public_ip" { value = ["${aws_instance.chef-server.public_ip}"] }