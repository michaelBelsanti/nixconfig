{ constants, ... }:
{
  unify = {
    nixos =
      { config, ... }:
      {
        _module.args.homeConfig = config.home-manager.users.${constants.user};
        home-manager.useUserPackages = true;
        home-manager.useGlobalPkgs = true;
      };

    home = {
      home = {
        inherit (constants) username;
        homeDirectory = "/home/${constants.user}";
        stateVersion = "22.05";
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
      };
      programs.home-manager.enable = true;
    };
  };
}
