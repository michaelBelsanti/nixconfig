{
  delib,
  pkgs,
  lib,
  host,
  ...
}:
delib.module {
  name = "programs.ghostty";
  options.programs.ghostty = with delib; {
    enable = boolOption host.isWorkstation;
    default = boolOption true;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackages = [ pkgs.ghostty ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "com.mitchellh.ghostty.desktop" ];
    };
  home.ifEnabled.programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      window-decoration = "server";
      window-padding-x = 4;
      window-padding-color = "extend";
      keybind = [
        "ctrl+alt+v=new_split:right"
        "ctrl+alt+s=new_split:down"
        "ctrl+alt+n=new_split:auto"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+l=goto_split:right"
        "ctrl+shift+w=close_surface"
        "page_up=scroll_page_fractional:-0.5"
        "page_down=scroll_page_fractional:+0.5"
        "performable:ctrl+c=copy_to_clipboard"
      ];
    };
  };
}
