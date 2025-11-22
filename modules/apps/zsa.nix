{
  styx.apps._.zsa.nixos =
    { pkgs, ... }:
    {
      hardware.keyboard.zsa.enable = true;
      environment.systemPackages = with pkgs; [
        keymapp
        wally-cli
      ];
    };
}
