{ den, __findFile, ... }:
{
  den.aspects = {
    workstation = den.lib.parametric.atLeast {
      includes = [
        <boot>
        <secrets>
        <services/easyeffects>
        <services/flatpak>
        <services/printing>
        <services/ssh/client>
        <services/syncthing/client>
        <theming>
        <wayland/cosmic>

        <virt/podman>
        <virt/qemu>
        <tailscale>

        <udev>
        <xdg>
      ];
    };
    laptop = den.lib.parametric.atLeast {
      includes = [
        <boot/graphical>
        <boot/secure>
        <performance/responsive>
        <power-management>
        <workstation>
      ];
    };
    desktop = den.lib.parametric.atLeast {
      includes = [
        <performance/max>
        <services/ssh>
        <workstation>
      ];
    };
    server = den.lib.parametric.atLeast {
      includes = [
        <filesystem/zfs>
        <performance>
        <services/ssh>
        <virt/podman>
      ];
    };
  };
}
