{
  unify.modules.workstation.home =
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
