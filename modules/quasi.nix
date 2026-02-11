{ __findFile, ... }:
{
  den.aspects.quasi = {
    includes = [
      <den/primary-user>
      <styx/helix/with-tools>
      <styx/nushell>
      <styx/shell>
    ];
    nixos.users.users.quasi = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIezBKQfXf4ZHTKyCBavmlIXVFhJ7xd4MltEubJe9Kxe quasi@hades"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQ8s7HeNm2rc4jxPdontGgXy3am1qSkXDbOgnT4Kz+J quasi@zagreus"
      ];
      extraGroups = [
        "docker"
        "wireshark"
      ];
    };
  };
  den.hosts.x86_64-linux.hades.users.quasi = { };
  den.hosts.x86_64-linux.zagreus.users.quasi = { };
}
