{ pkgs, ... }:
{
  environment.pathsToLink = [ "/share/wordlists" ];
  environment.systemPackages = with pkgs; [
    burpsuite
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
  ];
}

