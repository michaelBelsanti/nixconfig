{
  perSystem =
    { pkgs, ... }:
    {
      packages.secrethound =
        let
          inherit (pkgs) fetchFromGitHub lib;
          inherit (pkgs) buildGoModule;
        in
        buildGoModule {
          pname = "secrethound";
          version = "1.0.0";

          src = fetchFromGitHub {
            owner = "rafabd1";
            repo = "SecretHound";
            rev = "d853832d2384b3e6030b24173b18f3b9822ff2c3";
            hash = "sha256-nXL7ly4W4MIXy3DcWeTPfP3t77M72EDxaqjQWwNu/TY=";
          };

          vendorHash = "sha256-oTyI3/+evDTzyH+BjfSP0A1r2bYVAMxtWRsg0G1d2zQ=";

          ldflags = [
            "-s"
            "-w"
          ];

          meta = {
            description = "A fast and powerful CLI tool for finding secrets and other data in files, web pages, and other text sources";
            homepage = "https://github.com/rafabd1/SecretHound";
            license = lib.licenses.mit;
            maintainers = [ ];
            mainProgram = "secrethound";
          };
        };
    };
}
