{
  delib,
  pkgs,
  wrapper-manager,
  constants,
  host,
  homeConfig,
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
      burpsuite
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

      metasploit

      (pkgs.writeScriptBin "cyberchef" ''
        echo ${pkgs.cyberchef}/share/cyberchef/index.html
      '')

      (wrapper-manager.lib.build {
        inherit pkgs;
        modules = [
          {
            wrappers.rustscan = {
              basePackage = pkgs.rustscan;
              flags = [ "-c ${constants.configHome}/rustscan.toml" ];
            };
          }
          # {
          #   wrappers.metasploit = {
          #     basePackage = pkgs.metasploit;
          #     flags = [ "--defer-module-loads" ];
          #   };
          # }
        ];
      })
    ];
  };
}
