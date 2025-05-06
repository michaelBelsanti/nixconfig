{
  unify.modules.workstation = {
    nixos.programs.localsend.enable = true;
    home =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.localsend ];
      };
  };
}
