{ config, pkgs, ... }:
{
  imports = 
    [
      ../packages/user.nix
      ../modules/zsh.nix
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "quasi";
  home.homeDirectory = "/home/quasi";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.file = { };

  # Main system theming
  xresources.path = "$HOME/X11/xresources";
  gtk = {
    enable = true;
    font = {
      name = "Montserrat Semibold";
      package = pkgs.montserrat;
      size = 12;
    };
    # iconTheme = "Adwaita";
    theme.name = "Catppuccin-Purple-Dark";
    theme.package = pkgs.catppuccin-gtk;
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  # home.pointerCursor.package = pkgs.phinger-cursors;
  # home.pointerCursor.name = "Phinger Cursors";

  # Git
  programs.git = {
    enable = true;
    userName = "quasigod-io";
    userEmail = "quasigod-io@protonmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

}
