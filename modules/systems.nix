{ den, __findFile, ... }:
{
  den.aspects = {
    workstation = den.lib.parametric {
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
      ];
    };
    laptop = den.lib.parametric {
      includes = [
        <boot/graphical>
        <boot/secure>
        <performance/responsive>
        <power-management>
        <workstation>
      ];
    };
    desktop = den.lib.parametric {
      includes = [
        <performance/max>
        <services/ssh>
        <workstation>
      ];
    };
    server = den.lib.parametric {
      includes = [
        <filesystem/zfs>
        <performance>
        <services/ssh>
        <virt/podman>
      ];
    };
  };
}
