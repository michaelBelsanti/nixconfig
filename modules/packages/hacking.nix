{
  inputs,
  constants,
  lib,
  ...
}:
{
  unify.modules.hacking = {
    nixos.programs.wireshark.enable = true;
    home =
      { pkgs, ... }:
      {
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
          feroxbuster

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

          (inputs.wrapper-manager.lib.build {
            inherit pkgs;
            modules = lib.singleton {
              wrappers.rustscan = {
                basePackage = pkgs.rustscan;
                flags = [ "-c ${constants.configHome}/rustscan.toml" ];
              };
            };
          })
        ];
      };
  };
}
