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
  nixos.ifEnabled = {
    programs.wireshark.enable = true;
  };
  home.ifEnabled = {
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
      rustscan
      theharvester
      enum4linux-ng
      smbmap

      
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
