resource "aws_security_group" "SG_App" {
  name        = var.sg_name
  description = "Allow inbound traffic on port 8080(jenkins), 22(TCP), 9000(sonarqube), 3000(Grafana), 9090(prometheus), 80(Applciation server)"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
}

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}  

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    
}   

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   
}
}

resource "aws_instance" "jenkins" {
  ami           = "ami-023a307f3d27ea427"
  instance_type = "t2.medium"
  key_name      = var.key_name
  security_groups = [aws_security_group.SG_jenkins.name]
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "appserver" {
  ami           = ami-023a307f3d27ea427
  instance_type = t2.medium
  key_name      = var.key_name
  security_groups = [aws_security_group.SG_jenkins.name]
  tags = {
    Name = "AppServer"
  }
}

resource "aws_instance" "monitoring" {
  ami           = ami-023a307f3d27ea427
  instance_type = t2.small
  key_name      = var.key_name
  security_groups = [aws_security_group.SG_jenkins.name]
  tags = {
    Name = "Monitoring"
  }
}

resource "aws_instance" "logging" {
  ami           = ami-023a307f3d27ea427
  instance_type = t2.micro
  key_name      = var.key_name
  security_groups = [aws_security_group.SG_jenkins.name]
  tags = {
    Name = "Logging"
  }
}

resource "aws_instance" "sonarqube" {
    ami = ami-023a307f3d27ea427
    instance_type = t2.medium
    key_name = var.key_name
    security_groups = [aws_security_group.SG_jenkins.name]
    tags = {
        Name = "SonarQube"
    }  
}