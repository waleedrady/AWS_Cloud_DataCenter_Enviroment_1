// Creating Internet Gateway
resource "aws_internet_gateway" "WRady_Terraform_Virginia_IGW" {
  vpc_id = aws_vpc.SDWAN_VPC.id
  tags = {
    Name       = "${var.username}_Terraform_IGW"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// Route Table

// Virgina Public Route Table  (Main / Default Route Table)

resource "aws_default_route_table" "Virginia_Public_Subnet_RT" {
  default_route_table_id = aws_vpc.SDWAN_VPC.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.WRady_Terraform_Virginia_IGW.id
  }

  tags = {
    Name       = "${var.username}_Terraform_Virgina_Public_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}

// Virgina Private Subnet Route Table

resource "aws_route_table" "Virgina_Private_Subnet_RT" {
  vpc_id = aws_vpc.SDWAN_VPC.id

  tags = {
    Name       = "${var.username}_Terraform_Virgina_Private_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_route" "Virgina_Private_Subnet_Default_Route" {
  route_table_id         = aws_route_table.Virgina_Private_Subnet_RT.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_network_interface.FGT_eth1]
  network_interface_id   = aws_network_interface.FGT_eth1.id

}


// Security Groups


resource "aws_default_security_group" "default_SG" {
  vpc_id = aws_vpc.SDWAN_VPC.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name       = "${var.username}_SDWAN_Default_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}


resource "aws_security_group" "Public_SG" {
  name        = "${var.username}_SDWAN_Public_Allow_SG"
  description = "Public Allow traffic"
  vpc_id      = aws_vpc.SDWAN_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10443
    to_port     = 10443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.username}_SDWAN_Public_Allow_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_security_group" "Private_SG" {
  name        = "${var.username}_SDWAN_Private_SG"
  description = "Allow all traffic for the Private Subnet"
  vpc_id      = aws_vpc.SDWAN_VPC.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.username}_SDWAN_Private_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// FortiManager Security Group

resource "aws_security_group" "FMG_SG" {
  name        = "${var.username}_FortiManager_SG"
  description = "FortiManager_SG"
  vpc_id      = aws_vpc.SDWAN_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 541
    to_port     = 541
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.username}_FortiManager_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}
