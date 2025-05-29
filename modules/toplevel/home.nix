{
  unify = {
    nixos =
      { config, hostConfig, ... }:
      {
        _module.args.homeConfig = config.home-manager.users.${hostConfig.primaryUser};
        home-manager.useUserPackages = true;
        home-manager.useGlobalPkgs = true;
      };

    home = {
      home = {
        stateVersion = "22.05";
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
      };
      programs.home-manager.enable = true;
    };
  };
}
