// Apache instance


// Apache Interface

resource "aws_network_interface" "Ubuntu_WebServer_eth0" {
  description = "${var.username}_Terraform_Apache_eth0"
  subnet_id   = aws_subnet.Virginia_Private_Subnet_1.id
  private_ips = var.Ubuntu_LAN_IP

  tags = {
    Name = "${var.username}_TF_Ubuntu_WebServer_Eth0"
  }
}

resource "aws_network_interface_sg_attachment" "LAN_Interface_to_Private_SG_Attachment" {
  depends_on           = [aws_network_interface.Ubuntu_WebServer_eth0]
  security_group_id    = aws_security_group.Private_SG.id
  network_interface_id = aws_network_interface.Ubuntu_WebServer_eth0.id
}


resource "time_sleep" "wait_6mins_40seconds" {
  depends_on      = [aws_instance.WRady_Terraform_FGT]
  create_duration = "400s"
}


resource "aws_instance" "Apache" {
  depends_on        = [time_sleep.wait_6mins_40seconds]
  ami               = lookup(var.Ubuntu_WebServer_AMI, var.US_East_1)
  instance_type     = var.Ubuntu_VM_Size
  availability_zone = data.aws_availability_zones.AZs_US_East_1.names[0]
  key_name          = var.keyname

  root_block_device {
    volume_type = "standard"
    volume_size = "8"
  }

  network_interface {
    network_interface_id = aws_network_interface.Ubuntu_WebServer_eth0.id
    device_index         = 0
  }

  user_data = <<-EOF
  #!/bin/bash
  sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
  systemctl restart sshd
  service sshd restart
  #
  #TO DO: replace admin with your desired username
  #
  useradd admin
  sudo usermod -aG sudo admin
  sudo mkdir /home/admin
  sudo usermod --shell /bin/bash --home /home/admin admin
  sudo chown -R admin:admin /home/admin
  cp /etc/skel/.* /home/admin/
  #
  #TO DO: replace password123 with your desired password and admin with your username
  #
  yes password123 | sudo passwd admin
  #
  #      Install Apache  
  #
  sudo apt update -y
  sudo apt install -y apache2
  #
  #      Start Apache Service
  #
  sudo systemctl start apache2
  sudo systemctl enable apache2
  #
  #      Give User permissions to modify the /var/www folder 
  #
  sudo chown -R $USER:$USER /var/www
  #
  #      Create a simple webpage to be displayed by the Apache Server
  #
  echo "<html><style>body { font-size: 15px;}</style><body><h1>Hello, Fortinet PS Team &#128075</h1><h2>This is our first Apache Server created via Terraform &#128079 &#128170; </h2></body></html>" > /var/www/html/index.html
  #
  #     Install Ubuntu Simple Desktop (GNOME Terminal)  
  #
  sudo apt install -y gnome-session gnome-terminal
  #sudo apt-get install -y lxde
  #
  #     Install Firefox
  #
  sudo apt install -y firefox
  #
  #     Enable RDP 
  #
  sudo apt install -y xrdp
  sudo adduser xrdp ssl-cert
  #
  #    Restart the RDP service to enable it
  #
  sudo systemctl restart xrdp
  sudo reboot
  #sudo apt-get install -y w3m
  EOF

  tags = {
    Name = "${var.username}_TF_Ubuntu_Apache_Server"
  }
}

