{
  unify.modules.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        calibre
        kcc
        p7zip # for kcc
      ];
    };
}
