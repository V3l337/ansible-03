# сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr
}

# вм по кол-ву
resource "yandex_compute_instance" "vm" {
  count = var.instance_count
  name = var.instance_names[count.index]
  hostname = var.instance_names[count.index]

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.deb.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", { 
        ssh_public_key = file(var.ssh_public_key)
     })
  }
}

