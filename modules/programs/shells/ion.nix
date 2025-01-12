{ delib, pkgs, ... }:
delib.module {
  name = "programs.shells.ion";
  options = delib.singleEnableOption false;
  nixos.ifEnabled.environment.shells = [ pkgs.ion ];
  home.ifEnabled = {
    programs.ion = {
      enable = true;
      shellAliases = {
        lg = "lazygit";
        open = "xdg-open";
      };
      initExtra = "source-sh ~/.profile";
    };
  };
}
