{ delib, ... }:
delib.host {
  name = "nyx";
  rice = "catppuccin";
  type = "server";

  homeManagerSystem = "x86_64-linux";
  nixos.nixpkgs.hostPlatform = "x86_64-linux";
}
