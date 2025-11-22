{
  styx.ai._.ollama.nixos =
    { lib, config, ... }:
    {
      services.ollama = {
        enable = true;
        user = "ollama";
        host = "[::]";
        openFirewall = true;
        rocmOverrideGfx =
          let
            env = config.environment.sessionVariables;
            val = "HSA_OVERRIDE_GFX_VERSION";
          in
          lib.mkIf (builtins.hasAttr val env) env.${val};
      };
    };
}
