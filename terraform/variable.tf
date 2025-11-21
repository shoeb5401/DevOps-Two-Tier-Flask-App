variable "local_public_key" {
    type = string
    default = "access.pem"
}
variable "ami_id" {
    type = string
    default = "ami-02b8269d5e85954ef"
  
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "ec2_name" {
  type = string
  default = "MyEc2Instance"
}