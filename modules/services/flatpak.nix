{
  config,
  lib,
  mylib,
  ...
}:
{
  options.services.flatpak.enable = mylib.mkEnabledIf "workstation";
  config.nixos = lib.mkIf config.services.flatpak.enable {
    appstream.enable = true;
    services.flatpak.enable = true;
  };
}
