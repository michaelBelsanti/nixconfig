{
  perSystem =
    { pkgs, ... }:
    {
      packages.xsstrike =
        let
          inherit (pkgs)
            fetchFromGitHub
            python3Packages
            ;
        in
        python3Packages.buildPythonApplication {
          pname = "xsstrike";
          version = "0-unstable-2025-05-04";

          src = fetchFromGitHub {
            owner = "boffman";
            repo = "XSStrike";
            rev = "73d103ce9162f2edc40ebee808f302625dc90eb0";
            hash = "sha256-I1QOvup07JeiXZYgoF0rxlEoMI398y3qEYC6qQ2x+l0=";
          };
          pyproject = true;
          pythonImportsCheck = [ "xsstrike" ];
          build-system = with python3Packages; [ setuptools ];
          dependencies = with python3Packages; [
            tld
            fuzzywuzzy
            requests
          ];
        };
    };
}
