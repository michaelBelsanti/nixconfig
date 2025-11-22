{
  styx.apps._.nh = {
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
