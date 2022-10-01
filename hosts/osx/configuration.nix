{ config, pkgs, user, ... }:

{
  imports = [
    ../../packages/hosts/osx
    ../nix.nix
    # ../../modules/yabai
    ../../modules/noyabai
  ];
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  fonts = {
    fontDir.enable = false;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      montserrat
    ];
  };

  users.users.${user}.home = "/Users/${user}";
  
  
  # Make apps installed with Nix appear in spotlight
  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" ~/Applications/Nix\ Apps
      done
    ''
  );
  
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = true;
    };
  };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;
  
  # 
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowBroken = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
