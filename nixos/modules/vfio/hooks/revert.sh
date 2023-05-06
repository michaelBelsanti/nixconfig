#!/usr/bin/env bash

# debug
set -x

# load variables
source "/etc/libvirt/hooks/kvm.conf"

# unload vfio-pci
modprobe -r vfio_pci
# modprobe -r vfio
# modprobe -r vfio_iommu_type1

# rebind gpu
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO

modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia

sleep 5

# bind efi-framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

# rebind vtconsoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# read nvidia x config
# nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# restart display service
systemctl start display-manager.service


# systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
# systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
# systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
