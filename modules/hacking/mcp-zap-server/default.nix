{
  perSystem =
    { pkgs, ... }:
    {
      packages.mcp-zap-server =
        let
          inherit (pkgs)
            lib
            fetchFromGitHub
            stdenv
            gradle
            makeWrapper
            jre
            ;
        in
        stdenv.mkDerivation (finalAttrs: {
          pname = "mcp-zap-server";
          version = "0.2.1";
          src = fetchFromGitHub {
            owner = "dtkmn";
            repo = "mcp-zap-server";
            rev = "v${finalAttrs.version}";
            hash = "sha256-YaJJi3RDUEeeeG+LlmAKX9VBsVlZkrysFcNBzRnEQHE=";
          };
          mitmCache = gradle.fetchDeps {
            pkg = finalAttrs.finalPackage;
            data = ./deps.json;
          };
          nativeBuildInputs = [
            gradle
            makeWrapper
          ];
          installPhase = ''
            mkdir -p $out/{bin,share/mcp-zap-server}
            cp -pr build/. $out/share/mcp-zap-server

            makeWrapper ${lib.getExe jre} $out/bin/mcp-zap-server \
              --add-flags "-Dspring.ai.mcp.server.type=sync -jar $out/share/mcp-zap-server/libs/mcp-zap-server-${finalAttrs.version}-SNAPSHOT.jar"
          '';
        });
    };
}
