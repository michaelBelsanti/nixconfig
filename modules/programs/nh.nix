{
  delib,
  constants,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nh";
  nixos.always = {
    programs.nh = {
      enable = true;
      flake = constants.flakePath;
    };
  };
  home.always = {
    home.packages = [ pkgs.nh ];
    home.sessionVariables = {
      FLAKE = constants.flakePath;
    };
  };
}
