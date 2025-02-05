{ delib, host, inputs, ... }:
delib.module {
  name = "services.flatpak";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled.imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
  nixos.ifEnabled = {
    appstream.enable = true;
    services.flatpak.enable = true;
  };
}
