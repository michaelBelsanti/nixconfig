{
  appimageTools,
  fetchurl,
  lib,
# makeWrapper,
}:
let
  pname = "nexus-mods-app";
  version = "0.4.1";

  src = fetchurl {
    url = "https://github.com/Nexus-Mods/NexusMods.App/releases/download/v${version}/NexusMods.App.x86_64.AppImage";
    hash = "sha256-Zvs4EK082s9NE1sj/eonUL6Fr5akUZPeNlvcxCTLQCk=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [ pkgs.icu ];

  meta = with lib; {
    description = "Home of the development of the Nexus Mods App";
    homepage = "https://github.com/Nexus-Mods/NexusMods.App";
    changelog = "https://github.com/Nexus-Mods/NexusMods.App/blob/v${version}/CHANGELOG.md";
    license = licenses.gpl3Only;
    mainProgram = "nexus-mods";
    platforms = platforms.all;
  };
}
