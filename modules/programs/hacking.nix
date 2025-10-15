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
        environment.etc.hosts.mode = "0644";
        # until exegol supports podman
        virtualisation.docker.enable = true;
        programs.wireshark.enable = true;
        users.users.${hostConfig.primaryUser}.extraGroups = [
          "wireshark"
          "docker"
        ];
      };
    home =
      { pkgs, config, ... }:
      {
        home.packages = with pkgs; [
          exegol
          # general
          wordlists
          (writeScriptBin "wlfuzz" ''
            ${lib.getExe television} files ${wordlists}/share/wordlists -s "fd . -t l" -p "${lib.getExe bat} {}" | tee /dev/tty | ${lib.getExe' wl-clipboard "wl-copy"}
          '')

          # Information Gathering
          nmap
          theharvester
          enum4linux-ng
          smbmap
          gobuster
          feroxbuster
          sherlock
          amass
          # ProjectDiscovery tools
          subfinder
          dnsx
          naabu
          httpx
          nuclei
          uncover
          cloudlist
          tlsx
          notify
          mapcidr
          interactsh
          katana
          cvemap
          (withSystem system (p: p.config.packages.shuffledns))
          massdns

          # Vulnerability Analysis
          sqlmap
          bruno

          # Exploitation Tools
          exploitdb
          responder
          netexec
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
          dalfox

          # Reverse Engineering
          ghidra
          cutter
          imhex

          # Social Engineering Tools
          social-engineer-toolkit

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
          caido
        ];
      };
  };
}
