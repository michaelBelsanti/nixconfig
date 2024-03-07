{
  appimageTools,
  fetchurl,
  lib,
}: let
  pname = "affine";
  version = "0.12.2";
  src = fetchurl {
    url = "https://github.com/toeverything/AFFiNE/releases/download/v${version}/affine-stable-linux-x64.AppImage";
    hash = "sha256-zxXoe2TaDpM79M+3avj6lsdge/doBivmGUIloSFCAN4=";
  };
  appimageContents = appimageTools.extractType2 {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      mv $out/bin/{${pname}-${version},AFFiNE}
      mkdir -p $out/share/{applications,pixmaps}
      cp ${appimageContents}/AFFiNE.desktop $out/share/applications
      cp ${appimageContents}/AFFiNE $out/share/pixmaps
    '';

    meta = with lib; {
      homepage = "https://affine.pro/";
      description = "AFFiNE is a workspace with fully merged docs, whiteboards and databases.";
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      mainProgram = "AFFiNE";
      platforms = ["x86_64-linux"];
      maintainers = with maintainers; [michaelBelsanti];
    };
  }
