variable "service_account_key_file" {
  default = "/root/ansible/ansible-03/authorized_key.json"
}
variable "cloud_id" {}
variable "folder_id" {}
variable "zone" {
  type    = string
  default = "ru-central1-a"
}
variable "vpc_name" {
  type    = string
  default = "develop"
}
variable "cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
data "yandex_compute_image" "deb" {
  family = "debian-11"
}
variable "instance_count" {
  type    = number
  default = 3
}
variable "instance_names" {
  type    = list(string)
  default = ["clickhouse", "vector", "lighthouse"]
}
variable "cores" {
  type    = number
  default = 2
}
variable "memory" {
  type    = number
  default = 4
}
variable "core_fraction" {
  type    = number
  default = 5
}
variable "disk_size" {
  type    = number
  default = 20
}
variable "ssh_public_key" {
  type    = string
  default = "/root/ansible/ansible-03/sshkey.pub"
  description = "ключ указывается для подключения в inventory.yml"
}
variable "ssh_private_key_file" {
  type    = string
  default = "/root/ansible/ansible-03/sshkey"
  description = "ключ на сервер для подключения"
}
variable "ansible_inventory_path" {
  type        = string
  default     = "/root/ansible/ansible-03/playbook/invenroty/"
  description = "Куда сохранять файл"
}
variable "host_groups" {
  type = map(list(string))
  default = {
    "clickhouse" = ["clickhouse"]
    "vector"     = ["vector"]
    "lighthouse" = ["lighthouse"]
  }
  description = "для инвентори файла"
}
