{
  unify = {
    nixos =
      { hostConfig, ... }:
      {
        programs.nh = {
          enable = true;
          flake = "/home/${hostConfig.primaryUser}/.flake";
        };
      };
    home =
      { pkgs, config, ... }:
      {
        home.packages = [ pkgs.nh ];
        home.sessionVariables.FLAKE = "${config.home.homeDirectory}/.flake";
      };
  };
}
