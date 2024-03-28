{ config, lib, ... }:
let
  user = config.users.mainUser;
in
{
  config.snowfallorg.users.${user}.home.config = lib.mkIf config.desktop.hyprland.enable {
    programs.walker = {
      enable = true;
      runAsService = true;
      style = builtins.readFile ./style.css;
      config = {
        placeholder = "Search...";
        notify_on_fail = true;
        show_initial_entries = true;
        orientation = "vertical";
        terminal = "footclient";
        activation_mode = {
          use_alt = true;
        };
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
        external = lib.lists.singleton ({
          prefix = "!";
          name = "power";
          src = "walker-power";
        });
        icons = {
          size = 28;
          image_height = 200;
        };
        align = {
          horizontal = "center";
          vertical = "start";
          width = 500;
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
      };
    };
  };
}
