{
  perSystem =
    { pkgs, ... }:
    {
      packages.shuffledns =
        let
          inherit (pkgs) fetchFromGitHub versionCheckHook;
        in
        pkgs.buildGoModule {
          pname = "shuffledns";
          version = "1.1.0";
          src = fetchFromGitHub {
            owner = "projectdiscovery";
            repo = "shuffledns";
            rev = "v1.1.0";
            hash = "sha256-wfHGIWdksfe0sNss4pLQ0ODh28u2kMuxAJh5C9Uiap4=";
          };
          vendorHash = "sha256-A4Ssvc6UOvwezzdMa+nPkwyVT8j15+mTAAL+loeBcCo=";
          subPackages = [ "cmd/shuffledns" ];
          nativeInstallCheckInputs = [ versionCheckHook ];
          ldflags = [
            "-s"
            "-w"
          ];
          versionCheckProgramArg = "-version";
        };
    };
}
