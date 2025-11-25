{
  styx.services._.printing.nixos =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
      };
    };
}
