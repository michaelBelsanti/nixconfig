{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "posy-improved-cursors";
  version = "bd2bac08bf01e25846a6643dd30e2acffa9517d4";

  src = fetchFromGitHub {
    owner = "simtrami";
    repo = "posy-improved-cursor-linux";
    rev = "bd2bac08bf01e25846a6643dd30e2acffa9517d4";
    sha256 = "sha256-ndxz0KEU18ZKbPK2vTtEWUkOB/KqA362ipJMjVEgzYQ=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/
    cp -r Posy_Cursor* $out/share/icons/
    runHook postInstall
  '';

  meta = {
    description = "This is a Linux port of Michiel de Boer's amazing cursor design.";
    homepage = "https://github.com/simtrami/posy-improved-cursor-linux";
    platforms = lib.platforms.linux;
  };
}
