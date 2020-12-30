#
resource "google_compute_address" "static_ip_desc7" {
  name    = "static-ip-desc7"
#  purpose = "GCE_ENDPOINT"
}

resource "google_compute_firewall" "allow-desc" {
  name    = "desc-firewall"
  network =  google_compute_network.vpc_network.id
  depends_on = [google_compute_network.vpc_network]

  target_tags = ["desc-fw"]

  allow {
    protocol = "tcp"
    ports    = var.allow_ports_desk
  }
  allow {
    protocol = "udp"
    ports    = var.allow_ports_desk
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_instance" "vm_desc7" {
  name         = "vm-desc7"
  machine_type = "n1-highmem-2"
  tags         = ["desc", "centos-7", "desc-fw"]
  deletion_protection = true
  depends_on = ["google_compute_address.static_ip_desc7", "google_compute_network.vpc_network"]

  metadata = {
   ssh-keys = "root:${file(var.public_key_path_of_root)} terr:${file(var.public_key_path)}" 
  }
  metadata_startup_script = "id > /test.txt"

  boot_disk {
    initialize_params {
      size = 50
      image = var.disk_image
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.private_subnetwork.id
    access_config {
       nat_ip = google_compute_address.static_ip_desc7.address
    }
  }
}

resource "null_resource" "ansible" {
  depends_on = ["google_compute_instance.vm_desc7"]
  connection {
      type = "ssh"
      user = "terr"
      host =  "${google_compute_instance.vm_desc7.network_interface.0.access_config.0.nat_ip}"
      private_key = "${file(var.private_key_path)}"
      agent = false   
  }
#  provisioner "file" {
#    source      = "${file(var.private_key_path)}"
#    destination = "$HOME/.ssh"
#  }
 
  provisioner "file" {
    source      = "./roles"
    destination = "$HOME"
  }
  provisioner "file" {
    source      = "./playbook.yml"
    destination = "$HOME/playbook.yml"
  }
  provisioner "file" {
    source      = "./conf_vars.yml"
    destination = "$HOME/conf_vars.yml"
  }
  provisioner "file" {
    source      = "./inv_localhost"
    destination = "$HOME/inv_localhost"
  }
  provisioner "remote-exec" {
    inline = [
      "curl https://bootstrap.pypa.io/get-pip.py |sudo python",
      "sudo pip install ansible",
      "sudo /usr/bin/ansible-playbook -v -i inv_localhost ./playbook.yml ",
    ]
  }

}
