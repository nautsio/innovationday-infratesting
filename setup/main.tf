resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
    route_table_id         = "${aws_vpc.default.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
    vpc_id                  = "${aws_vpc.default.id}"
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
}


resource "aws_security_group" "default" {
    name        = "ci"
    vpc_id      = "${aws_vpc.default.id}"

    # SSH access from anywhere
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTP access from the VPC
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # outbound internet access
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "auth" {
    key_name   = "infratesting"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnD6HHM7SQQnFTpf6F2TJZBCH005VMiTZiO32GQrL241d7s9/zSvMk4p5WKtpcM0Cd23XRKxnAEBR5I0Vgs9s5XQkLcg+S8yRAMvN0wGM5kiICPIxs93Gp1tYHhw5NsxI0AmqoW7ITimooI0gRY1vjRal1mwm8vIonhCue6TLu5mAL3GaqLrDrxqF+AAaQ2dh4FnBi2pgkNe+h37X/Z52GZRNqV3cTUkRS4ZAR9LG67ukIweZUsiiYZA5TDlm4oHFylXBV7NOFfb4tmb78y5zsCgPSU/GLOj3oKhjfLv/rgQws528deoVmaGCEMcaofcE+5MJ88XDklXj3KHTxx6L5 infratesting@xebia.com"
}


resource "aws_instance" "ci" {
    ami = "ami-2a1fad59"
    instance_type = "t2.small"
    # The name of our SSH keypair we created above.
    key_name = "${aws_key_pair.auth.id}"

    # Our Security group to allow HTTP and SSH access
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
    user_data = "${file(\"coreos.yml\")}"
    # We're going to launch into the same subnet as our ELB. In a production
    # environment it's more common to have a separate private subnet for
    # backend instances.
    subnet_id = "${aws_subnet.default.id}"
    tags {
        Name = "InfraTesting"
    }
}

