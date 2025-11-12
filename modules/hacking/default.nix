{
  inputs,
  lib,
  withSystem,
  den,
  ...
}:
{
  den.aspects.hax = {
    includes = [ den.aspects.hax._.subfinder ];
    nixos = {
      environment.etc.hosts.mode = "0644";
      # TODO until exegol supports podman
      virtualisation.docker.enable = true;
      programs.wireshark.enable = true;
      users.users.quasi.extraGroups = [
        # TODO
        "wireshark"
        "docker"
      ];
    };
    homeManager =
      { pkgs, config, ... }:
      {
        sops.secrets.shodan_api_key = { };
        sops.templates."subfinder-providers.yaml".content = lib.generators.toYAML { } {
          shodan = [ config.sops.placeholder.shodan_api_key ];
        };
        home.packages = with pkgs; [
          exegol
          # general
          wordlists
          (writeScriptBin "wlfuzz" ''
            #!${lib.getExe nushell}

            ${lib.getExe television} files ${wordlists}/share/wordlists -s "fd . -t l" -p "${lib.getExe bat} {}"
              | $"${wordlists}/share/wordlists/($in)"
              | tee { print $in }
              | ${lib.getExe' wl-clipboard "wl-copy"}
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
          waymore
          # ProjectDiscovery tools
          (inputs.wrapper-manager.lib.wrapWith pkgs {
            basePackage = pkgs.subfinder;
            env.SUBFINDER_PROVIDER_CONFIG.value = "${config.sops.templates."subfinder-providers.yaml".path}";
          })
          alterx
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

          (withSystem system (p: p.config.packages.uro))
          (withSystem system (p: p.config.packages.gf))
          (withSystem system (p: p.config.packages.secrethound))
          (withSystem system (p: p.config.packages.secretfinder))

          # Vulnerability Analysis
          sqlmap
          bruno
          (withSystem system (p: p.config.packages.arjun))

          # Exploitation Tools
          exploitdb
          responder
          netexec

          # Wireless Attacks
          aircrack-ng

          # Forensics Tools
          # autopsy # TODO
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
          caido
          wafw00f
          graphw00f

          # Reverse Engineering
          ghidra
          cutter
          # imhex # TODO

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
          # (inputs.wrapper-manager.lib.wrapWith pkgs {
          #   basePackage = (withSystem system (p: p.config.packages.mcp-zap-server));
          #   env = {
          #     ZAP_API_PORT.value = "8080";
          #     ZAP_API_URL.value = "localhost";
          #     ZAP_API_KEY.value = "h8a0huc1mmp3efmjbu2e8hqhs";
          #   };
          # })
        ];
      };
  };
}
