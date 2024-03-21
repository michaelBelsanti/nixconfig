{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage {
  pname = "hyprsome";
  version = "unstable-2023-06-08";

  src = fetchFromGitHub {
    owner = "sopa0";
    repo = "hyprsome";
    rev = "9636be05ef20fbe473709cc3913b5bbf735eb4f3";
    hash = "sha256-f4Z5gXZ74uAe770guywGIznXiI/3a/617MD2uZNQNVA=";
  };

  cargoHash = "sha256-FcsTWydEtcGP6fvsdax/PAd2c2d7MM+HVbhqsIc4ong=";

  meta = with lib; {
    description = "Awesome-like workspaces for Hyprland";
    homepage = "https://github.com/sopa0/hyprsome";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "hyprsome";
  };
}
