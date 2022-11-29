{ config, user, ... }:
{
  imports = 
    [
      ../modules/cli
      ../modules/shell/osx
      ../modules/wezterm
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${user}";
  home.homeDirectory = "/Users/${user}";

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
  
  # Git
  programs.git = {
    enable = true;
    userName = "quasigod-io";
    userEmail = "quasigod-io@protonmail.com";
    delta.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  
  home.sessionVariables = {
    EDIR_EDITOR = "hx";
    BROWSER = "librewolf";
    FZF_DEFAULT_COMMAND = "find .";
  };
}
