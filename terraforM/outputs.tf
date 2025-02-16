resource "local_file" "ansible_inventory" {
  filename = "/root/ansible/ansible-03/playbook/inventory.yml"
  content  = <<-EOT
  all:
    children:
  %{for group, hosts in var.host_groups~}
    ${group}:
        hosts:
  %{for host in hosts~}
        ${host}:
            ansible_host: ${yandex_compute_instance.vm[index(var.instance_names, host)].network_interface[0].nat_ip_address}
            ansible_user: v3ll
            ansible_ssh_private_key_file: ${var.ssh_private_key_file}
  %{endfor~}
  %{endfor~}
  EOT
}
