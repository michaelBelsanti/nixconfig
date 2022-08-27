# debugging
set -x

# load variables we defined
source "/etc/libvirt/hooks/kvm.conf"

# Isolate host to core 0
systemctl set-property --runtime -- user.slice AllowedCPUs=0
systemctl set-property --runtime -- system.slice AllowedCPUs=0
systemctl set-property --runtime -- init.scope AllowedCPUs=0

# stop display manager
systemctl stop display-manager.service

#unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

#unbind efi-framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# avoid race condition
sleep 5

# unload nvidia
modprobe -r nvidia_drm nvidia_modeset drm_kms_helper nvidia i2c_nvidia_gpu drm nvidia_uvm

#unbind GPU
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

# load info
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1
