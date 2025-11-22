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
        <styx/power-management>
        <styx/workstation>
      ];
    };
    desktop = den.lib.parametric.atLeast {
      includes = [
        <styx/performance/max>
        <styx/services/ssh>
        <styx/workstation>
      ];
    };
    server = den.lib.parametric.atLeast {
      includes = [
        <styx/filesystem/zfs>
        <styx/performance>
        <styx/services/ssh>
        <styx/virt/podman>
        <styx/networking/static>
      ];
    };
  };
}
