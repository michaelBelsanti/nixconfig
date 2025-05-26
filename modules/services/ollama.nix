{
  unify.modules.localai.nixos = {
    services.ollama = {
      enable = true;
      acceleration = "rocm";
      user = "ollama";
    };
  };
}
