{
  styx.ssh.provides = {
    client.homeManager.services.ssh-agent.enable = true;
    server.nixos.services.openssh = {
      enable = true;
      openFirewall = true;
    };
  };
}
