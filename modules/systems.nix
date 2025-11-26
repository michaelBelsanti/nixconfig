{ den, __findFile, ... }:
{
  styx = {
    workstation = den.lib.parametric.atLeast {
      includes = [
        <styx/boot>
        <styx/networking>
        <styx/secrets>
        <styx/easyeffects>
        <styx/flatpak>
        <styx/printing>
        <styx/ssh/client>
        <styx/syncthing/client>
        <styx/theming>
        <styx/wayland/cosmic>
        <styx/filesystems/ntfs>
        <styx/virt/podman>
        <styx/virt/qemu>
        <styx/tailscale>
        <styx/udev>
        <styx/xdg>
      ];
    };
    laptop = den.lib.parametric.atLeast {
      includes = [
        <styx/boot/graphical>
        <styx/boot/secure>
        <styx/performance/responsive>
        <styx/power-mgmt>
        <styx/workstation>
      ];
    };
    desktop = den.lib.parametric.atLeast {
      includes = [
        <styx/performance/max>
        <styx/ssh/server>
        <styx/workstation>
        <styx/networking/wol>
      ];
    };
  };
}
