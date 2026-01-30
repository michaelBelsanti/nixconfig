{ lib, inputs, ... }:
{
  styx.dev.homeManager =
    { pkgs, ... }:
    {
      home.packages = lib.mkMerge [
        (with pkgs; [
          jjui
          jq
          kondo
        ])
        (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
          opencode
          nanocoder
          agent-browser
          ck
        ])
      ];
    };
}
