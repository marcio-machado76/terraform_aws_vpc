variable "cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "region" {
  type        = string
  description = "Região na AWS"
}

variable "count_available" {
  type        = number
  description = "Numero de Zonas de disponibilidade"
}

variable "vpc" {
  type        = string
  description = "Id da VPC"
}

variable "tag_vpc" {
  description = "Tag Name da VPC"
  type        = string
}

variable "tag_igw" {
  description = "Tag Name do internet gateway"
  type        = string
}

variable "tag_rtable" {
  description = "Tag Name das route tables"
  type        = string
}

variable "nacl" { 
    description = "Regras de network acl"
}

