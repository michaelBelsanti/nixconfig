{
  pkgs,
  user,
  ...
}: {
  # Import automatically generated plasma-manager config
  # Generated using 'rc2nix' or `nix run github:pjones/plasma-manager`
  home-manager.users.${user}.imports = [./plasma-manager.nix];

  services.xserver = {
    desktopManager.plasma5.enable = true;
    displayManager.defaultSession = "plasmawayland";
  };
  environment.systemPackages = with pkgs; [
    # Theming / Customization
    (catppuccin-kde.override {
      flavour = ["macchiato"];
      accents = ["mauve"];
    })
    # lightly-qt
    # libsForQt5.lightly
    libsForQt5.polonium

    ark
    krusader
    haruna
    yakuake
    partition-manager

    rc2nix
  ];
}
