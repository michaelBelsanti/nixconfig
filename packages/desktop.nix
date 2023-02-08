{ pkgs, user, ... }: {
  imports = [ ./common/system.nix ./gaming ];

  environment.systemPackages = with pkgs; [ pciutils ];
  home-manager.users.${user}.imports = [
    ./common/home.nix
    ./programming
  ];
}
