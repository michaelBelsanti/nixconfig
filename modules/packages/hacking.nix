{
  delib,
  pkgs,
  lib,
  inputs,
  ...
}:
delib.module rec {
  name = "packages.hacking";
  options = delib.singleEnableOption true;
  nixos.always.environment.systemPackages = home.always.home.packages;
  home.always = {
    home.packages = with pkgs; [
      zap
      thc-hydra
      seclists
      hashcat
      hashcat-utils
      responder
      nmap
      dnschef
      wireshark
      exploitdb
      metasploit
      cyberchef
      ffuf
      imhex
      mitmproxy
      mitmproxy2swagger
    ];
    wrapper-manager.packages.hacking = {
      wrappers.burpsuite = {
        arg0 = lib.getExe pkgs.burpsuite;
        appendArgs = [ "--disable-auto-update" ];
        xdg.desktopEntry.enable = true;
      };
    };
  };
}
