{ sources, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.xsstrike = pkgs.python3Packages.buildPythonApplication {
        inherit (sources.xsstrike) pname src;
        version = "0-unstable-${sources.xsstrike.date}";
        pythonImportsCheck = [ "xsstrike" ];
        build-system = with pkgs.python3Packages; [ setuptools ];
        dependencies = with pkgs.python3Packages; [
          tld
          fuzzywuzzy
          requests
        ];
      };
    };
}
