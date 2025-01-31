{ delib, host, ... }:
delib.module {
  name = "services.sshd";
  options = delib.singleEnableOption host.isServer;
  nixos.ifEnabled = {
    services.openssh = {
      enable = true;
      settings = {
        # following ssh-audit: nixos default minus 2048 bit modules
        KexAlgorithms = [
          "sntrup761x25519-sha512@openssh.com"
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
        ];
        # following ssh-audit: nixos defaults minus encrypt-and-MAC
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];
        RequiredRSASize = 4095;
      };
    };
  };
}
