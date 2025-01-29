{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.kitty";
  options.programs.kitty = with delib; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackages = [ pkgs.kitty ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "kitty.desktop" ];
    };
  home.ifEnabled = {
    programs.kitty = {
      enable = true;
      font = {
        name = "monospace";
        size = 12;
      };
      settings = {
        clear_all_shortcuts = true;
        enable_audio_bell = false;
        update_check_interval = 0;
        confirm_os_window_close = 0;
        hide_window_decorations = true;
      };
      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+equal" = "change_font_size all +2.0";
        "ctrl+shift+plus" = "change_font_size all +2.0";
        "ctrl+shift+kp_add" = "change_font_size all +2.0";
        "ctrl+shift+minus" = "change_font_size all -2.0";
        "ctrl+shift+kp_subtract" = "change_font_size all -2.0";
        "ctrl+shift+backspace" = "change_font_size all 0";
      };
    };
  };
}
