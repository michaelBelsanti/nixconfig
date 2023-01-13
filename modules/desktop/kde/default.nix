{ pkgs, user, ... }:
{
  # Import automatically generated plasma-manager config
  # Generated using 'rc2nix' or `nix run github:pjones/plasma-manager`
  home-manager.users.${user}.imports = [ ./plasma-manager.nix ../../wezterm ];
  environment.systemPackages = with pkgs; [
    # Theming / Customization
    catppuccin-kde
    lightly-qt
    libsForQt5.lightly
    libsForQt5.bismuth

    wezterm
    ark
    krusader
    haruna

    rc2nix
  ];
}
