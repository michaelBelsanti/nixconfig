{
  perSystem =
    { pkgs, ... }:
    {
      packages.gf =
        let
          inherit (pkgs) fetchFromGitHub lib;
          inherit (pkgs) buildGoModule;
        in
        buildGoModule {
          pname = "gf";
          version = "unstable-2020-06-18";

          src = fetchFromGitHub {
            owner = "tomnomnom";
            repo = "gf";
            rev = "dcd4c361f9f5ba302294ed38b8ce278e8ba69006";
            hash = "sha256-deG0yNpSKxdXQEjdyMYNbNiA+z7CK3FRmEgkvUoF7p4=";
          };

          # This is a legacy Go project without go.mod or go.sum
          vendorHash = null;

          postPatch = ''
            go mod init github.com/tomnomnom/gf
          '';

          ldflags = [
            "-s"
            "-w"
          ];

          postInstall = ''
            install -Dm444 $src/gf-completion.bash $out/share/bash-completion/completions/gf
            install -Dm444 $src/gf-completion.fish $out/share/fish/vendor_completions.d/gf.fish
            install -Dm444 $src/gf-completion.zsh $out/share/zsh/site-functions/_gf
          '';

          meta = {
            description = "A wrapper around grep, to help you grep for things";
            homepage = "https://github.com/tomnomnom/gf";
            license = lib.licenses.mit;
            maintainers = [ ];
            mainProgram = "gf";
          };
        };
    };
}
