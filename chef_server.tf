resource "aws_instance" "chef-server" {
  count = "${var.count}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  key_name = "${var.key_name}"
  ami = "${var.ami}"
  tags {
    Name = "${var.org}-${var.env}-${var.service}"
  }
  root_block_device {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
  }

  provisioner "remote-exec" {
    inline = [
      "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-server"
    ]
    connection {
      user = "${var.ssh_user}"
      private_key = "${var.ssh_private_key}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash -c 'cat <<EOT > /etc/opscode/chef-server.rb \n${var.chef_server_settings}\nEOT'",
      "sudo chef-server-ctl reconfigure"
    ]
    connection {
      user = "${var.ssh_user}"
      private_key = "${var.ssh_private_key}"
    }
  }
}

resource "aws_route53_record" "chef-server-record" {
  zone_id = "${var.cammy_dns_zone_id}"
  name = "chef.internal.cammy.ec2"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_instance.chef-server.private_ip}"]
}
