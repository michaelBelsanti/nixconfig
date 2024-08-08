_: {
  # for sshmux daemon
  apps.wezterm.enable = true;
  programs.starship.settings.hostname.ssh_only = false;
  theming = {
    enable = true;
    theme = "catppuccin";
  };
}
