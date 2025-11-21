# creating a local public key to access the  remote ec2 instance
resource "tls_private_key" "rsa_private_key" {
	algorithm = "RSA"
	
}
resource "local_sensitive_file" "local_public_key" {
	filename = var.local_public_key
	content = tls_private_key.rsa_private_key.private_key_pem
}

# creating the ec2 instance and its various configurations needed


resource "aws_key_pair" "deploy" {
  key_name = "access"
  public_key = tls_private_key.rsa_private_key.public_key_openssh
}
resource "aws_security_group" "ec2_security_group" {
	name = "basic-ec2-sg"
	description = "Allow ssh, http, app port, jenkins port"
	ingress  {
		description = "ssh"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ] 

	}
	ingress  {
		description = "http"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ] 

	}
	ingress  {
		description = "App port"
		from_port = 5000
		to_port = 5000
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ] 

	}
	ingress  {
		description = "Jenkins port"
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ] 

	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]

	}

	tags = {
	  Name = "ec2-basic-sg"
	}
  
}



resource "aws_instance" "default_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  user_data = file("install.sh")
  key_name = aws_key_pair.deploy.key_name
   tags = {
	 Name = var.ec2_name
   }
	root_block_device {
	  volume_size = 20
	  volume_type = "gp3"

	}
	vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

}

