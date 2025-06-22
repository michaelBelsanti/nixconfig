{ inputs, ... }:
{
  unify.modules.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        calibre
        kcc
        p7zip # for kcc
        (inputs.wrapper-manager.lib.wrapWith pkgs {
          basePackage = pkgs.hakuneko;
          prependFlags = [ "--no-sandbox" ]; # gpu errors without
        })
      ];
    };
}
