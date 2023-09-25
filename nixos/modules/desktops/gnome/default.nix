{
  pkgs,
  user,
  ...
}: {
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [gnome.gnome-tweaks];
  home-manager.users.${user} = {
    home.packages = with pkgs.gnomeExtensions; [
      forge
      # space-bar
    ];
  };
}
