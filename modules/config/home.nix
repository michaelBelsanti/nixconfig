{ delib, constants, ... }:
delib.module {
  name = "home";

  home.always = {
    home = {
      inherit (constants) username;
      homeDirectory = "/home/${constants.username}";
      stateVersion = "22.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
    };
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}
