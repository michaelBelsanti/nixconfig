{
  styx.services._.ssh.provides = {
    client.homeManager.services.ssh-agent.enable = true;
    server.nixos = {
      environment.enableAllTerminfo = true;
      services.openssh = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
