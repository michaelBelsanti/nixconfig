{
  perSystem =
    { pkgs, ... }:
    {
      packages.secretfinder =
        let
          inherit (pkgs) fetchFromGitHub lib;
          inherit (pkgs.python3Packages) buildPythonPackage;
        in
        buildPythonPackage {
          pname = "secretfinder";
          version = "2.2.0";
          format = "other";

          src = fetchFromGitHub {
            owner = "m4ll0k";
            repo = "SecretFinder";
            rev = "d06119dedd9c1505137d1ec4792d5d5b65c7425d";
            hash = "sha256-PXmW8t7g6JC12R/xDTi6MN5R2XM3b2zzHH6GVeZfBxk=";
          };

          propagatedBuildInputs = with pkgs.python3Packages; [
            requests
            jsbeautifier
            requests-file
            lxml
          ];

          sourceRoot = "source";

          installPhase = ''
            install -Dm755 SecretFinder.py $out/bin/secretfinder
          '';

          meta = {
            description = "Find secrets from a JavaScript/HTML file";
            homepage = "https://github.com/m4ll0k/SecretFinder";
            license = lib.licenses.gpl3Only;
            maintainers = [ ];
            mainProgram = "secretfinder";
          };
        };
    };
}
