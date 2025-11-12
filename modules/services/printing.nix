{
  den.aspects.services._.printing.nixos =
    { pkgs, ... }:
    {
      services = {
        printing = {
          enable = true;
          drivers = [ pkgs.hplip ];
        };
        avahi = {
          enable = true;
          nssmdns4 = true;
        };
      };
    };
}
