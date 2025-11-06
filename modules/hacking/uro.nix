{
  perSystem =
    { pkgs, ... }:
    {
      packages.uro =
        let
          inherit (pkgs) fetchFromGitHub lib;
          inherit (pkgs.python3Packages) buildPythonPackage;
        in
        buildPythonPackage {
          pname = "uro";
          version = "1.0.2";
          format = "setuptools";

          src = fetchFromGitHub {
            owner = "s0md3v";
            repo = "uro";
            rev = "db6fdd896030fb2fd5b447f75fa79db31040cd0b";
            hash = "sha256-aDFUyWkje4TqsmxnPfQAhf2k4rFMdibxfHHvQks9yRA=";
          };

          meta = {
            description = "A python tool to declutter url lists for crawling/pentesting";
            homepage = "https://github.com/s0md3v/uro";
            license = lib.licenses.asl20;
            maintainers = [ ];
            mainProgram = "uro";
          };
        };
    };
}
