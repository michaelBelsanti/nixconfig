{pkgs, ...}: {
  imports = [./.];
  services.xserver.displayManager.defaultSession = "plasmawayland";
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
