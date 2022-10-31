{ config, pkgs, lib, inputs, ... }:
let 
  wine-tkg = inputs.nix-gaming.packages.${pkgs.system}.wine-tkg;
in
{
  # Using mkForce because lib.mkDefault can't be used in nixos/configuration.nix
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    gamescope
    winetricks
    protontricks
    grapejuice
    (lutris.override {lutris-unwrapped = lutris-unwrapped.override {wine = wine-tkg;};})
    heroic
    goverlay
    mangohud
    # TODO - Replace PolyMC with PrismLauncher
    prismlauncher
    
    # For use with gamemode. Hugepages can increase performance in some games
    (writeShellScriptBin "gmstart" ''
      echo 'always' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
      polybar-msg action gamemode module_show
      togdnd -p
    '')
    (writeShellScriptBin "gmstop" ''
      echo 'madvise' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
      polybar-msg action gamemode module_hide
      togdnd -u
    '')
  ];

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  hardware.steam-hardware.enable = true;
}
