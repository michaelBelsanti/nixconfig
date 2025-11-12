{
  den.aspects.apps._.localsend = {
    nixos.programs.localsend.enable = true;
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.localsend ];
      };
  };
}
