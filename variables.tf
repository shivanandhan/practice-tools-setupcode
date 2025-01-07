variable "tools" {
  default = {
    vault = {
      port        = 8200
      volume_size = 20
      instance_type = "t3.small"
      policy_list = []
    }

    github-runner = {
      port        = 80 # dummy port
      volume_size = 20
      instance_type = "t3.small"
      policy_list = ["ec2:*","route53:*"]
    }
  }
}

variable "zone_id"{
  default ="Z01735512UFOFLO7B90DS"
  }

variable "domain_name" {
  default = "kndevops72.online"
}