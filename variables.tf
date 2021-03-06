variable count { default = "1" }
variable org { default = "cammy" }
variable env { default = "infrastructure" }
variable service { default = "chef-server" }
variable instance_type { default = "t2.small" }
variable availability_zone { default = "ap-southeast-2c" }
variable ebs_optimized { default = "true" }
variable region { default = "ap-southeast-2" }
variable security_groups {
  type = "list"
  default = [ "base-security-group" ]
}
variable ami { default = "ami-ca340da9" }
variable ssh_user { default = "ec2-user" }
variable ssh_private_key { default = "" }
variable key_name { default = "ops" }
variable volume_type { default = "gp2" }
variable volume_size { default = "10" }
variable chef_server_settings { default = "" }
