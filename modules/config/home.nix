{ delib, constants, config, isHomeManager, ... }:
delib.module {
  name = "home";
  myconfig.always.args.shared.homeConfig =
    if isHomeManager
    then config
    else config.home-manager.users.${constants.username};
  nixos.always.home-manager.useGlobalPkgs = true;
  home.always = {
    home = {
      inherit (constants) username;
      homeDirectory = "/home/${constants.username}";
      stateVersion = "22.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
    };
    programs.home-manager.enable = true;
  };
}
