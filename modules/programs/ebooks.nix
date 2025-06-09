{ inputs, lib, ... }:
{
  unify.modules.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        calibre
        (inputs.wrapper-manager.lib.build {
          inherit pkgs;
          modules = lib.singleton {
            wrappers.hakuneko = {
              basePackage = pkgs.hakuneko;
              flags = [ "--no-sandbox" ];
            };
          };
        })
      ];
    };
}
