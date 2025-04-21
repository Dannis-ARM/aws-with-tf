# Read the existing private key from a file in the user's profile directory (Windows compatible)
data "local_file" "existing_private_key" {
  filename = "${pathexpand("~")}\\.ssh\\${var.ec2_key_name}"
}

# Extract the public key from the existing private key
data "tls_public_key" "existing_public_key" {
  private_key_pem = data.local_file.existing_private_key.content
}

# Create an AWS Key Pair using the extracted public key
resource "aws_key_pair" "ec2-keypair" {
  key_name   = var.ec2_key_name
  public_key = data.tls_public_key.existing_public_key.public_key_openssh
}
