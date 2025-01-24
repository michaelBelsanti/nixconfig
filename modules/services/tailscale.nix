{ delib, pkgs, ... }:
delib.module {
  name = "services.tailscale";
  options.services.tailscale = with delib; {
    enable = boolOption true;
    remote = boolOption false;
  };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackage = [ pkgs.trayscale ];
      services.tailscale = {
        enable = true;
        extraSetFlags =
          if cfg.remote then
            [
              "--accept-routes"
            ]
          else
            [
              "--accept-dns=false"
            ];
      };
    };
}
