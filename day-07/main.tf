provider "aws" {
  region = "us-east-1"
}

provider "vault" {
    address = "http://3.86.238.120:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "52b953d4-cf99-bc7a-1864-9351017ece1d"
      secret_id = "bbbe69e7-338d-5970-3d76-1d5c496b94b8"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name = "test-secret"
}

resource "aws_instance" "revisntance" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags ={ 
  name="test"
  secret=data.vault_kv_secret_v2.example.data["username"]
  }

}

