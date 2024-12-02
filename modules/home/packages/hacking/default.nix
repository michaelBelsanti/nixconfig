{ pkgs, lib, ... }:
{
  home.file.wordlists = {
    source = pkgs.seclists + /share/wordlists;
  };
  home.packages = with pkgs; [
    zap
    (lib.wrapper-manager.build {
      inherit pkgs;
      modules = [
        {
          wrappers.stack = {
            basePackage = pkgs.burpsuite;
            flags = [
              "--disable-auto-update"
            ];
          };
        }
      ];
    })
    thc-hydra
    seclists
    hashcat
    hashcat-utils
    responder
    nmap
    dnschef
    wireshark
    exploitdb
    metasploit
    cyberchef
    ffuf
    imhex
    mitmproxy
    mitmproxy2swagger
  ];
}
