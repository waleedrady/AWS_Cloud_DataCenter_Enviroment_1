# DataCenter Enviroment 1
Terraform Module that will create the AWS Networking Stack with FGT, FMG and an Apache Server and utilize AWS Route53 for DNS. 

The module will create the below resources:

- Networking Stack (VPC, Subnets, Route Tables, Security Groups and Internet Gateway) - Please refer to the diagram below. 
- FortiGate with 2 interfaces (one in the Public and one in the Private subnets)
- FortiManager in the public subnet
- Ubunutu Server with Apache installed on it.  (username: user / password: fortinet123)
- 2 x Route53 DNS Hosted Zones (one public and one Private)


// The DNS Hosted Zones must be sub-zones for a domain that is registered or managed by AWS Route53 //

// i.e xyz.com is the domain name and you will create the subzone Lab1.xyz.com // 


## There's 7 required variables that must be filled

-     line 7 =  Your AWS IAM account Access Key
-     Line 8 =  Your AWS IAM Account Secret Key

-     Line 12 = Your username (1st initial / Last name)
-     Line 13 = Copy and Paste your AWS Keypair name (EC2 --> Network & Security --> Key Pairs)
-     Line 14 = TO DO: Change the password from "fortinet123" to your own password

-     Line 18 = Your Public Hosted Zone in Route53 (This is a requirement that you have a public DNS zone either registered with Route53 or managed by it (i.e xyz.com)
-     Line 19 = Your Sub Hosted Zone name for this lab (i.e lab.xyz.com)

    
-----------------


![image](https://user-images.githubusercontent.com/83562796/117002411-87a72880-acb1-11eb-911c-6f48d8bfaf74.png)
