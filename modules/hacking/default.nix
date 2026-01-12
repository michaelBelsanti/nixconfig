{
  inputs,
  lib,
  styx,
  den,
  ...
}:
{
  styx.hax = den.lib.parametric {
    includes = [
      styx.hax._.subfinder
      (styx.groups [
        "wireshark"
      ])
    ];
    nixos = {
      environment.etc.hosts.mode = "0644";
      programs.wireshark.enable = true;
    };
    homeManager =
      { pkgs, config, ... }:
      {
        sops.secrets.shodan_api_key = { };
        sops.templates."subfinder-providers.yaml".content = lib.generators.toYAML { } {
          shodan = [ config.sops.placeholder.shodan_api_key ];
        };
        home.packages =
          with pkgs;
          let
            inherit (stdenv.hostPlatform) system;
          in
          [
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
            shuffledns
            massdns

            uro
            secrethound
            inputs.nur.packages.${system}.gf

            # Vulnerability Analysis
            sqlmap
            bruno
            (arjun.overrideAttrs {
              version = "0-unstable-2025-02-20";
              src = pkgs.fetchFromGitHub {
                owner = "s0md3v";
                repo = "Arjun";
                rev = "d1fb995cb1e064d4e171d83f19f6af79b0a3c5ce";
                hash = "sha256-z6YGCwypp69+98KSC1YUzJETfwb3V4Qp1sV5V3N9zMI=";
              };
            })

            # Exploitation Tools
            exploitdb
            responder
            netexec
            python3Packages.impacket

            # Wireless Attacks
            aircrack-ng

            # Forensics Tools
            # autopsy
            volatility3
            binwalk
            exiftool
            # sleuthkit

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
            zap
            firefox-bin # for zap
            ffuf
            xh
            wpscan
            dalfox
            wafw00f
            graphw00f

            # Reverse Engineering
            ghidra
            cutter
            imhex

            # Social Engineering Tools
            social-engineer-toolkit

            # Miscellaneous
            inputs.nur.packages.${system}.strix
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
