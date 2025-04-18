# Generate an RSA private key
resource "tls_private_key" "nb-keypair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content  = tls_private_key.nb-keypair.private_key_pem
  filename = "${path.root}/${var.ec2_key_name}.pem"
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "nb-keypair" {
  key_name   = var.ec2_key_name
  public_key = tls_private_key.nb-keypair.public_key_openssh
}