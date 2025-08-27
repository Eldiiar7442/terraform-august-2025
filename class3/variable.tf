variable region {
    type = string 
    description = "Enter region"
    default = "us-east-2"
}


variable key_name {
    type = string 
    default = "my-key-ohio"
    description = "Provide key-pair name"
}

variable key_file {
    type = string 
    description = "Provide key file location"
    default = "/home/ec2-user/.ssh/id_ed25519.pub"
}