{
  styx.printing.nixos =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
      };
    };
}
