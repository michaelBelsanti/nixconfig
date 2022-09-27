{ config, pkgs, ...}:
{
  imports = [
    ./btop
    ./helix
  ];
  xdg.configFile.test = {
    text = "${hostname}";
  };
}
