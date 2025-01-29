{ delib, host, ... }:
delib.module {
  name = "services.flatpak";
  options = delib.singleEnableOption host.hasGUI;
  nixos.ifEnabled = {
    appstream.enable = true;
    services.flatpak.enable = true;
  };
}
