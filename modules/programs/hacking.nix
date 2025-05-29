{
  inputs,
  lib,
  withSystem,
  ...
}:
{
  unify.modules.hacking = {
    nixos =
      { hostConfig, ... }:
      {
        programs.wireshark.enable = true;
        users.users.${hostConfig.primaryUser}.extraGroups = [ "wireshark" ];
        environment.etc.hosts.mode = "0644";
      };
    home =
      { pkgs, config, ... }:
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
          netexec
          metasploit
          (withSystem pkgs.system (p: p.config.packages.xsstrike))

          (pkgs.writeScriptBin "cyberchef" ''
            echo ${pkgs.cyberchef}/share/cyberchef/index.html
          '')

          (inputs.wrapper-manager.lib.build {
            inherit pkgs;
            modules = lib.singleton {
              wrappers.rustscan = {
                basePackage = pkgs.rustscan;
                flags = [ "-c ${config.xdg.configHome}/rustscan.toml" ];
              };
            };
          })
        ];
      };
  };
}
