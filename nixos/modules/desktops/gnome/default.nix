{
  pkgs,
  user,
  ...
}: {
  # Import automatically generated plasma-manager config
  # Generated using 'rc2nix' or `nix run github:pjones/plasma-manager`
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [gnome.gnome-tweaks];
  home-manager.users.${user} = {
    home.packages = with pkgs.gnomeExtensions; [
      pop-shell
      space-bar
    ];
  };
}
