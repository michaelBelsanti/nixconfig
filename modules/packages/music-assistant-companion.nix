{
  perSystem =
    { pkgs, ... }:
    {
      packages.music-assistant-companion =
        let
          inherit (pkgs)
            cargo-tauri
            fetchFromGitHub
            fetchYarnDeps
            nodejs
            pkg-config
            rustPlatform
            writableTmpDirAsHomeHook
            yarnBuildHook
            yarnConfigHook
            yarnInstallHook
            glib
            ;
        in
        rustPlatform.buildRustPackage (finalAttrs: {
          pname = "music-assistant-companion";
          version = "0-unstable";

          src = fetchFromGitHub {
            owner = "music-assistant";
            repo = "desktop-companion";
            rev = "d005a1be801e569c1c854fc923e89f58727d901f";
            hash = "sha256-PK5+hgStPu540jOlc8/do9qE2y7mJVcB6wU5Z/y8i54=";
            # fetchSubmodules = true;
          };

          offlineCache = fetchYarnDeps {
            yarnLock = finalAttrs.src + "/yarn.lock";
            hash = "sha256-2q/p/5Ypiio0LDMdQCluS5whymL9R4fX7PBA2aXAB+o=";
          };

          cargoHash = "sha256-bRcZFsSEuPNHBZq93EWlSIdtsJfivJTm3H/FhjTR6po=";
          cargoRoot = "src-tauri";
          buildAndTestSubdir = "src-tauri";

          nativeBuildInputs = [
            yarnInstallHook
            yarnConfigHook
            yarnBuildHook
            nodejs
            writableTmpDirAsHomeHook
            cargo-tauri.hook
            nodejs
            pkg-config
            yarnConfigHook
            glib
          ];
        });
    };
}
