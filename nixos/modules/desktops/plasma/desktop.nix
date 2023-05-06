{
  pkgs,
  user,
  ...
}: {
  imports = [./.];
  services.xserver.displayManager.defaultSession = "plasma";
  environment.systemPackages = with pkgs; [
    xclip
  ];
}
