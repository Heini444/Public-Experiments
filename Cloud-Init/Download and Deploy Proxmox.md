1. Download the ISO using the GUI (tested on https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64-disk-kvm.img)

https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
Create the Proxmox VM via CLI
```
#5000 = VM/CT Id, bridge=vmbr1 (adatapt to respective proxmox bridge)
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr1
#change Dir
cd /var/lib/vz/template/iso/
#import disk, change to respective storage pool and remove []
qm importdisk 5000 ubuntu-24-lts-noble-server-cloudimg-amd64.img [proxmox-storage-pool]
#changes to VM storage, found to be most performant - test and later as required.
qm set 5000 --scsihw virtio-scsi-pci --scsi0 [proxmox-storage-pool]:vm-5000-disk-0
Set ide2 as drive with cloudinit data
qm set 5000 --ide2 [proxmox-storage-pool]:cloudinit
#set boot drive
qm set 5000 --boot c --bootdisk scsi0
#add vga interface to view on proxmox, if required
qm set 5000 --serial0 socket --vga serial0
```
#Expand the VM disk size to a suitable size (suggested 10 GB)
#Create the Cloud-Init template 
navigate to cloud-init in proxmox interface, change accordingly
#Cloud-Init > copy ssh key from proxmox host, or preferrably generate new seporate key for production
nano /root/.ssh/id_rsa.pub
#Cloud-Init > Enable Upgrade Packages
#Cloud-Init > IP config - change to dhcp, reserve IPs in DHCP scope based on MAC
#Right click, Convert to template, BEFORE starting vm
#Deploy new VMs by cloning the template (full clone)
