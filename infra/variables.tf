variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  default     = "password123"
}

variable "db_name" {
  description = "The database name for the RDS instance"
  type        = string
  default     = "mydatabase"
}