{ delib, ... }:
delib.module {
  name = "home";

  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
      };
      programs.home-manager.enable = true;
      nixpkgs.config.allowUnfree = true;
      services.pueue.enable = true;
      xdg.enable = true;
    };
}
