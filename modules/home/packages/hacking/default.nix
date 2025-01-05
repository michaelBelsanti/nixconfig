{ pkgs, lib, ... }:
{
  home.file.wordlists = {
    source = pkgs.seclists + /share/wordlists;
  };
  home.packages = with pkgs; [
    zap
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
  wrapper-manager.packages.hacking = {
    wrappers.burpsuite = {
      arg0 = lib.getExe pkgs.burpsuite;
      appendArgs = [ "--disable-auto-update" ];
    };
  };
}
