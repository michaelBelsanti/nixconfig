{
  styx.apps._.vicinae.homeManager =
    { pkgs, lib, ... }:
    {
      programs.vicinae = {
        enable = true;
        systemd.enable = true;
        systemd.autoStart = true;
        settings.providers = {
          "@brpaz/store.vicinae.brotab".preferences.brotabPath = lib.getExe pkgs.brotab;
          "@knoopx/store.vicinae.firefox".preferences.profile_dir = ".zen/";
        };
      };
    };
}
