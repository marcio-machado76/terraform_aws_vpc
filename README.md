# terraform_aws_vpc
###
### Módulo para criar uma VPC na AWS composta dos recursos, Vpc, subnets (publicas e privadas), network Acls, route tables e internet gateway. Para utilizar este módulo é necessário os seguintes arquivos especificados logo abaixo:

   <summary>versions.tf - Arquivo com as versões dos providers.</summary>

```hcl
terraform {
    required_version = "~> 0.15.4"

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
 }
```
#
<summary>main.tf - Arquivo que irá consumir o módulo para criar a infraestrutura.</summary>

```hcl
provider "aws" {
  region  = var.region
  profile = "terraform"
}


module "network" {
  source          = "github.com/marcio-machado76/terraform_aws_vpc"
  region          = var.region
  cidr            = var.cidr
  count_available = var.count_available
  vpc             = module.network.vpc
  tag_vpc         = var.tag_vpc
  tag_igw         = var.tag_igw
  tag_rtable      = var.tag_rtable
  nacl            = var.nacl
}
```
#
<summary>variables.tf - Arquivo que contém as variáveis que o módulo irá utilizar e pode ter os valores alterados de acordo com a necessidade.</summary>

```hcl
variable "region" {
  type        = string
  description = "Região na AWS"
  default     = "us-east-1"
}

variable "cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "count_available" {
  type        = number
  description = "Numero de Zonas de disponibilidade"
  default     = 2
}

variable "tag_vpc" {
  description = "Tag Name da VPC"
  type        = string
  default     = "VPC-name"
}

variable "tag_igw" {
  description = "Tag Name do internet gateway"
  type        = string
  default     = "gw-name"
}

variable "tag_rtable" {
  description = "Tag Name das route tables"
  type        = string
  default     = "rt-name"
}

variable "nacl" {
  description = "Regras de Network Acls AWS"
  type        = map(object({ protocol = string, action = string, cidr_blocks = string, from_port = number, to_port = number }))
  default = {
    100 = { protocol = "tcp", action = "allow", cidr_blocks = "0.0.0.0/0", from_port = 22, to_port = 22 }
    105 = { protocol = "tcp", action = "allow", cidr_blocks = "0.0.0.0/0", from_port = 80, to_port = 80 }
    110 = { protocol = "tcp", action = "allow", cidr_blocks = "0.0.0.0/0", from_port = 443, to_port = 443 }
    150 = { protocol = "tcp", action = "allow", cidr_blocks = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
  }
}

```
#
<summary>outputs.tf - Outputs de recursos que serão utilizados em outros módulos.</summary>

```hcl

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | github.com/marcio-machado76/terraform_aws_vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR da VPC, exemplo "10.0.0.0/16" | `string` | `" "` | no |
| <a name="input_count_available"></a> [count\_available](#input\_count\_available) | Numero de Zonas de disponibilidade | `number` | `2` | no |
| <a name="input_nacl"></a> [nacl](#input\_nacl) | Regras de Network Acls AWS | `map(object)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Região na AWS, exemplo "us-east-1" | `string` | `" "` | no |
| <a name="input_tag_igw"></a> [tag\_igw](#input\_tag\_igw) | Tag Name do internet gateway | `string` | `""` | no |
| <a name="input_tag_rtable"></a> [tag\_rtable](#input\_tag\_rtable) | Tag Name das route tables | `string` | `""` | no |
| <a name="input_tag_vpc"></a> [tag\_vpc](#input\_tag\_vpc) | Tag Name da VPC | `string` | `""` | no |

## Outputs

No outputs.
