variable "resource_group" {
  type = map(any)
}
variable "virtual_network" {
  type = map(any)
}
variable "frontend_subnet" {
  type = map(any)
}

variable "public_ip_frontend" {
  type = map(any)
}
variable "key_vault" {
  type = map(any)
}

variable "username" {
  type = map(any)
}
variable "vm_password" {
  type = map(any)
}
variable "frontend_vm" {
  type = map(any)
}
variable "sql_server" {
  type = map(any)
}
variable "sql_database" {
  type = map(any)
}
