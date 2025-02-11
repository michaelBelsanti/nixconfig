{
  delib,
  host,
  constants,
  pkgs,
  ...
}:
delib.module {
  name = "services.syncthing";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled.home.packages = [ pkgs.syncthingtray ];
  nixos.ifEnabled = {
    services.syncthing = {
      enable = true;
      user = "quasi";
      settings.folders."/home/${constants.username}/sync".id = "default";
    };
  };
}
