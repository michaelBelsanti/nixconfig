{
  unify.modules.localai.nixos = {
    services.open-webui = {
      # enable = true; # TODO
      port = 8008;
      environment.WEBUI_AUTH = "False"; # only used locally
    };
  };
}
