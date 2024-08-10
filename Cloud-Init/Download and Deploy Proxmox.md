1. Download the ISO using the GUI (tested on https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64-disk-kvm.img)

https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
1. Create the VM via CLI
```
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr1
cd /var/lib/vz/template/iso/
qm importdisk 5000 ubuntu-24-lts-noble-server-cloudimg-amd64.img Virt-Pool-Local-2TB
qm set 5000 --scsihw virtio-scsi-pci --scsi0 Virt-Pool-Local-2TB:vm-5000-disk-0
qm set 5000 --ide2 Virt-Pool-Local-2TB:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
```
3. Expand the VM disk size to a suitable size (suggested 10 GB)
4. Create the Cloud-Init template 
#copy ssh key from proxmox host, preferrably generate new seporate key for production
nano /root/.ssh/id_rsa.pub
Enable Upgrade Packages
IP config - change to dhcp
Right click, Convert to template, before starting vm
5. Deploy new VMs by cloning the template (full clone)



ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEQt2YYU+w+K5BFJZwcJccJNs500qh1rvdijB2UhCiiYZMItajGDRGhNNJ+XiBs86lZONE7jWhOvcCdpU05r+PcSuOkfjUGM/claSfxPVslHzLz/pK9oSS4Hhi6ODk6Bh64jjgCk8FGf8bRNpgvKJgvO7GBb76OGZEJEoZMOaNoUhKEmBEE8N/llHLag+b/FJQtZiNYB09NE16Szbz3YhVK/S7lnaKRhXkpUTLnLTFsP1He3XsHkj+rad4cNRkcpjcUtEXErtNpUyx6YKXhLeDARrDq34EfQ6qT8F++gxp99ChD+rul7kjZAm/MiD166+mDJXybdk4at6LbJ28FnMP root@ussvirt02
