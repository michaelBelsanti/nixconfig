{ user, ... }: {
  xdg.configFile = {
    "zellij" = {
      recursive = true;
      source = ./zellij;
    };
  };
  programs.zellij = {
    enable = true;
  };
}
