{user, ...}: {
  imports = [./default.nix];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    # GDK_SCALE = "2";
  };
  snowfallorg.user.${user}.home.config = {
    xdg.configFile = {
      "waybar/config".source = ./waybar/config;
      hypr = {
        source = ./hypr;
        recursive = true;
      };
    };
  };
}
