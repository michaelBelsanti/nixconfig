{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "obs-cmd";
  version = "0.17.6";

  src = fetchFromGitHub {
    owner = "grigio";
    repo = "obs-cmd";
    rev = "v${version}";
    hash = "sha256-bZ3N0wCTXyCv6iBQDlieMDFa80yNu1XrI4W5EaN5y/I=";
  };

  cargoHash = "sha256-gIJOkWlBD1rv6bKf++v/pyI8/awdnZBo/U/5PFnEcvg=";

  meta = with lib; {
    description = "Obs-cmd is a OBS cli for obs-websocket v5 the current obs-studio implementation. It is useful on Wayland Linux or to control OBS via terminal";
    homepage = "https://github.com/grigio/obs-cmd";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "obs-cmd";
  };
}
