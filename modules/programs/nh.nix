{ constants, ... }:
{
  unify = {
    nixos.programs.nh = {
      enable = true;
      flake = constants.flakePath;
    };
    home =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.nh ];
        home.sessionVariables = {
          FLAKE = constants.flakePath;
        };
      };
  };
}
