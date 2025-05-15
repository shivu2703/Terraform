provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://52.90.8.110:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "0ddeba95-5e5f-aef0-3ede-deb9a8b05ea6"
      secret_id = "7ffc9751-b00b-b8df-b333-8607f17efb43"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}

resource "aws_instance" "example" {
  ami="ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name= "test"
    Secret=data.vault_kv_secret_v2.example.data["username"]
  }
}