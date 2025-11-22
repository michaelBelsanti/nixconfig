{
  styx.dev.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Dev
        jjui
        jq
        kondo
      ];
    };
}
