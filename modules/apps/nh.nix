{
  styx.apps._.nh = {
    nixos.srvos.update-diff.enable = false;
    homeManager =
      { config, ... }:
      {
        programs.nh = {
          enable = true;
          osFlake = "${config.home.homeDirectory}/.flake";
          homeFlake = "${config.home.homeDirectory}/.flake";
        };
      };
  };
}
