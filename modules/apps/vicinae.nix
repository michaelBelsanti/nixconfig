{
  styx.apps._.vicinae.homeManager = {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
      systemd.autoStart = true;
      settings.providers."@knoopx/store.vicinae.firefox".preferences.profile_dir = ".zen/";
    };
  };
}
