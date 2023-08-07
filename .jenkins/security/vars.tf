variable "project_credentials_file" {
    default = "credentials.json"
    description = "Path to the Google Cloud credentials JSON file"
}

variable "vpc-name" {
  default = "my-vpc"
  
}

variable "project_id" {
    default = "udapeople-new-395001"
  description = "Google Cloud Project ID"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-central1"
}

variable "e2-micro" {
  description = "Machine type for the Jenkins instance"
  default     = "e2-micro"
}

variable "zone" {
  description = "Google Cloud zone"
  default     = "us-central1-c"
}

variable "ubuntu" {
    default = "ubuntu-os-cloud/ubuntu-2004-lts"
  
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
