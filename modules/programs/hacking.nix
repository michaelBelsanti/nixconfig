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
          # TODO remove overrides eventually
          # general
          wordlists
          (writeScriptBin "wlfuzz" ''
            ${lib.getExe fd} . ${wordlists}/share/wordlists | ${lib.getExe television} files
          '')

          # Information Gathering
          nmap
          theharvester
          (enum4linux-ng.override {
            python3 = pkgs.python312;
          })
          (smbmap.override {
            python3 = pkgs.python312;
          })
          gobuster
          feroxbuster
          sherlock

          # Vulnerability Analysis
          sqlmap

          # Exploitation Tools
          exploitdb
          responder
          (netexec.override {
            python3 = pkgs.python312;
          })
          # metasploit

          # Wireless Attacks
          aircrack-ng

          # Forensics Tools
          autopsy
          volatility3
          binwalk
          exiftool
          sleuthkit

          # Stress Testing
          stress-ng

          # Sniffing & Spoofing
          wireshark
          bettercap
          python3Packages.scapy
          mitmproxy
          mitmproxy2swagger

          # Password Attacks
          thc-hydra
          hashcat
          hashcat-utils
          john
          ophcrack

          # Web Application Analysis
          whatweb
          burpsuite
          zap
          ffuf
          xh
          wpscan
          (withSystem system (p: p.config.packages.xsstrike))

          # Reverse Engineering
          ghidra
          cutter
          imhex

          # Social Engineering Tools
          (social-engineer-toolkit.override {
            python3Packages = pkgs.python312Packages;
          })

          # Miscellaneous
          tor-browser
          (writeScriptBin "cyberchef" ''
            ${lib.getExe' xdg-utils "xdg-open"} ${cyberchef}/share/cyberchef/index.html
          '')

          (inputs.wrapper-manager.lib.wrapWith pkgs {
            basePackage = pkgs.rustscan;
            prependFlags = [ "-c ${config.xdg.configHome}/rustscan.toml" ];
          })
          (inputs.wrapper-manager.lib.wrapWith pkgs {
            basePackage = pkgs.metasploit;
            programs.msfconsole.prependFlags = [ "--defer-module-loads" ];
          })
        ];
      };
  };
}
