{
  unify.modules.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Dev
        lazyjj
        lazygit
        jq
      ];
    };
}
