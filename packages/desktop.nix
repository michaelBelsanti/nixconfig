{ pkgs, user, ... }: {
  imports = [ ./common/system.nix ./gaming ];

  # environment.systemPackages = with pkgs; [ ];
  home-manager.users.${user}.imports = [
    ./common/home.nix
    ./programming
  ];
}
