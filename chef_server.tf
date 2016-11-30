resource "aws_instance" "chef-server" {
  count = "${var.count}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
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
      private_key = "${var.key_name}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash -c 'cat <<EOT > /etc/opscode/chef-server.rb \n${var.chef_server_settings}\nEOT'",
      "sudo chef-server-ctl reconfigure"
    ]
    connection {
      user = "${var.ssh_user}"
      private_key = "${var.key_name}"
    }
  }
}