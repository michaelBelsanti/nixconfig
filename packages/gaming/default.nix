{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    gamescope
    winetricks
    protontricks
    grapejuice
    gamemode
    (lutris.override {extraLibraries = pkgs: [pkgs.libunwind ];})
    heroic
    goverlay
    mangohud
    polymc
    
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
