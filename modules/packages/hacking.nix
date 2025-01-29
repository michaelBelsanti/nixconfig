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
      # general
      wordlists

      # cracker 
      thc-hydra
      hashcat
      hashcat-utils

      # web
      zap
      ffuf
      #burpsuite
      mitmproxy
      mitmproxy2swagger

      # enumeration
      nmap
      theharvester

      
      responder
      wireshark
      exploitdb
      metasploit
      cyberchef
      imhex
      python3Packages.scapy
      xh
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
