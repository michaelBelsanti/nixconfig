{ delib, host, ... }:
delib.module {
  name = "services.flatpak";
  options = delib.singleEnableOption host.isWorkstation;
  nixos.ifEnabled = {
    appstream.enable = true;
    services.flatpak.enable = true;
  };
}
