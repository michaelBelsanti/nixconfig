{
  xdg.configFile."walker/style.css".source = ./walker_style.css;
  programs.walker = {
    enable = true;
    runAsService = false;
    config = {
      activation_mode.use_alt = true;
      force_keyboard_focus = true;
      ignore_mouse = true;
      align = {
        anchors.top = true;
        horizontal = "center";
        vertical = "start";
        width = 500;
      };
      placeholder = "Search...";
      notify_on_fail = true;
      show_initial_entries = true;
      orientation = "vertical";
      terminal = "wezterm";
      scrollbar_policy = "automatic";
      ssh_host_file = "";
      modules = [
        { name = "applications"; }
        {
          prefix = "?";
          name = "websearch";
        }
        {
          prefix = "/";
          name = "hyprland";
        }
        {
          prefix = ".";
          name = "clipboard";
        }
      ];
      external = [
        {
          prefix = "!";
          name = "power";
          src = "walker-power";
        }
      ];
      icons = {
        size = 28;
        image_height = 200;
      };
      list = {
        margin_top = 10;
        height = 500;
        always_show = true;
      };
      search = { };
      clipboard = {
        image_height = 300;
        max_entries = 10;
      };
      hyprland = {
        context_aware_history = false;
      };
      applications = {
        disable_cache = true;
      };
    };
  };
}
