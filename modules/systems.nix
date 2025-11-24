{ den, __findFile, ... }:
{
  styx = {
    workstation = den.lib.parametric.atLeast {
      includes = [
        <styx/boot>
        <styx/networking>
        <styx/secrets>
        <styx/services/easyeffects>
        <styx/services/flatpak>
        <styx/services/printing>
        <styx/services/ssh/client>
        <styx/services/syncthing/client>
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
        <styx/services/ssh/server>
        <styx/workstation>
        <styx/networking/wired>
      ];
    };
  };
}
