{
  delib,
  pkgs,
  wrapper-manager,
  constants,
  ...
}:
delib.module {
  name = "packages.hacking";
  options = delib.singleEnableOption true;
  nixos.ifEnabled = {
    programs.wireshark.enable = true;
  };
  home.ifEnabled = {
    home.packages = with pkgs; [
      # general
      wordlists

      # crackers
      thc-hydra
      hashcat
      hashcat-utils

      # web
      zap
      ffuf
      mitmproxy
      mitmproxy2swagger

      # enumeration
      nmap
      # theharvester
      enum4linux-ng
      smbmap
      whatweb

      responder
      wireshark
      exploitdb
      cyberchef
      imhex
      python3Packages.scapy
      xh

      (wrapper-manager.lib.build {
        inherit pkgs;
        modules = [
          {
            wrappers.burpsuite = {
              basePackage = pkgs.burpsuite;
              flags = [ "--disable-auto-update" ];
            };
          }
          {
            wrappers.rustscan = {
              basePackage = pkgs.rustscan;
              flags = [ "-c ${constants.configHome}" ];
            };
          }
          {
            wrappers.metasploit = {
             basePackage = pkgs.metasploit; 
              flags = ["--defer-module-loads"];
            };
          }
        ];
      })
    ];
  };
}
