{
  styx.ssh.provides = {
    client.homeManager.services.ssh-agent.enable = true;
    server.nixos = {
      # environment.enableAllTerminfo = true; # TODO build failure
      services.openssh = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
