module "DataCenter-Enviroment_1" {
  source  = "WEEMR/DataCenter-Enviroment_1/aws"
  version = "0.0.5"

  # ------------------------------------------------------ AWS Account Settings ------------------------------------------ #

  access_key                = " < Access Key> "                      #  IAM Account Access Key
  secret_key                = " < Secret Key> "                      #  IAM Account Secret Key

  # ------------------------------------------------------ Variables ----------------------------------------------------- #

  username                  = " < username > "          #  Your 1st Initial, Last Name to tag resources i.e jdoe
  keyname                   = " < Key Pair > "          #  Your AWS Keypair to create resources
  Password                  = "fortinet123"             #  TO DO: Change the password from "fortinet123" to your own password

  # ------------------------------------------------------  DNS ------------------------------------------------------------ #

  Public_Hosted_Zone        = " < Public Hosted Zone > "       # You must have a domain registerd with AWS Route53 or Managed by AWS with a Hosted Zone Created. i.e xyz.com
  SubHosted_Zone            = " < Sub Hosted Zone > "          # Creates a Public SubHosted zone  - Enter a sub-hosted name for the domain above. i.e lab.xyz.com

  # the Private and Public Sub Hosted zone names will be the same*
  

  # ------------------------------------------------------ Reference Module ------------------------------------------------ #
  
  #                               Module = https://github.com/WEEMR/terraform-aws-DataCenter_Enviroment_1
  
}


#  ----------------  Outputs  -----------------  # 

output "Private_Subnet_ID" {
  value = module.DataCenter-Enviroment_1.Private_Subnet_ID
}

output "FMG_Username" {
  value = module.DataCenter-Enviroment_1.FMG_Username
}

output "FMG_Public_IP" {
  value = module.DataCenter-Enviroment_1.FMG_Public_IP
}


output "FortiManager_Password" {
  value = module.DataCenter-Enviroment_1.FortiManager_Password
}

output "FGT_EIP" {
  value = module.DataCenter-Enviroment_1.FGT_EIP
}

output "FortiGate_Password" {
  value = module.DataCenter-Enviroment_1.FortiGate_Password
}

output "Ubuntu_WebServer_Private_IP" {
  value = module.DataCenter-Enviroment_1.Ubuntu_WebServer_Private_IP
}
