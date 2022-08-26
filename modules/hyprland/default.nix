{ config, pkgs, ...}:
{
  programs.hyprland.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
  ];
  environment.systemPackages = with pkgs; [
    swaybg
    waybar
  ];

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };
}
