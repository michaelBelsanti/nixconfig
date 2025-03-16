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
      (pkgs.writeScriptBin "wlfuzz" ''
        ${lib.getExe fd} . ${wordlists}/share/wordlists | ${lib.getExe television} files
      '')

      # crackers
      thc-hydra
      hashcat
      hashcat-utils
      john

      # web
      zap
      ffuf
      mitmproxy
      mitmproxy2swagger

      # enumeration
      nmap
      theharvester
      enum4linux-ng
      smbmap
      whatweb
      gobuster
      sqlmap

      responder
      wireshark
      exploitdb
      imhex
      python3Packages.scapy
      xh

      (pkgs.writeScriptBin "cyberchef" ''
        echo ${pkgs.cyberchef}/share/cyberchef/index.html
      '')

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
              flags = [ "--defer-module-loads" ];
            };
          }
        ];
      })
    ];
  };
}
