{ user, ... }: {
  xdg.configFile = {
    "zellij/themes" = {
      recursive = true;
      source = ./themes;
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };
}
