{
  appimageTools,
  fetchurl,
  lib,
  makeWrapper,
}:
let
  pname = "affine";
  version = "0.14.0-canary.14";
  src = fetchurl {
    url = "https://github.com/toeverything/AFFiNE/releases/download/v${version}/affine-${version}-stable-linux-x64.appimage";
    hash = "sha256-zxXoe2TaDpM79M+3avj6lsdge/doBivmGUIloSFCAN4=";
  };
  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/{applications,pixmaps}
    cp ${appimageContents}/AFFiNE.desktop $out/share/applications
    cp ${appimageContents}/AFFiNE $out/share/pixmaps
    source "${makeWrapper}/nix-support/setup-hook"
    # wrapProgram $out/bin/AFFiNe \
    #   --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
  '';

  meta = with lib; {
    homepage = "https://affine.pro/";
    description = "AFFiNE is a workspace with fully merged docs, whiteboards and databases.";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "AFFiNE";
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ michaelBelsanti ];
  };
}
