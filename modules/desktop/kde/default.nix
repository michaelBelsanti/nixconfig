{ pkgs, user, ... }:
{
  # Import automatically generated plasma-manager config
  # Generated using `nix run github:pjones/plasma-manager`
  home-manager.users.${user}.imports = [ ./plasma-manager.nix ];
  environment.systemPackages = with pkgs; [
    # Theming / Customization
    catppuccin-kde
    libsForQt5.lightly
    libsForQt5.bismuth

    wezterm
    ark
  ];
}
