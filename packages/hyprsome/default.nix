{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "hyprsome";
  version = "unstable-2024-05-19";

  src = fetchFromGitHub {
    owner = "sopa0";
    repo = "hyprsome";
    rev = "985e1a3b03b5118c98c03983f60ea9f74775858c";
    hash = "sha256-JiOV9c23yOhaVW2NHgs8rjM8l9qt181Tigf5sCnPep8=";
  };

  cargoHash = "sha256-AFKHlFlMDnrno1OOTuEJGpHdKW5SkbvzkSLQGbLWpOI=";

  meta = with lib; {
    description = "Awesome-like workspaces for Hyprland";
    homepage = "https://github.com/sopa0/hyprsome";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "hyprsome";
  };
}
