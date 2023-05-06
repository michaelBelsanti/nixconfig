{ user, ... }: {
  imports = [ ./default.nix ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    # GDK_SCALE = "2";
  };
  home-manager.users.${user} = {
    xdg.configFile = {
      hypr = {
        source = ./hypr;
        recursive = true;
      };
      waybar = {
        source = ./waybar;
        recursive = true;
      };
    };
  };
}
