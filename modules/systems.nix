{ den, __findFile, ... }:
{
  den.aspects = {
    workstation = {
      includes = [
        <boot>
        <secrets>
        <services/easyeffects>
        <services/flatpak>
        <services/printing>
        <services/ssh/client>
        <services/syncthing/client>
        <theming>
        # <wayland/cosmic>

        <virt/podman>
        <virt/qemu>
        <tailscale>
      ];
    };
    laptop = {
      includes = [
        <boot/graphical>
        <boot/secure>
        <performance/responsive>
        <power-management>
        <workstation>
      ];
    };
    desktop = {
      includes = [
        <performance/max>
        <services/ssh>
        <workstation>
      ];
    };
    server = {
      includes = [
        <filesystem/zfs>
        <performance>
        <services/ssh>
        <virt/podman>
      ];
    };
  };
}
