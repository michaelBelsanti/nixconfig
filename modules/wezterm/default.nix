{ config, pkgs, ...}:
{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    local wezterm = require "wezterm"

    return {
    	color_scheme = "Catppuccin Mocha",
      font = wezterm.font("JetBrainsMono Nerd Font"),
      font_size = 12.0,
      harfbuzz_features = {"zero"},
      use_dead_keys = false,
      window_close_confirmation = "NeverPrompt",
      hide_tab_bar_if_only_one_tab = true
    }
  '';
}
