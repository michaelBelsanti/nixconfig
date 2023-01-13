{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "kde";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = pname;
    rev = "249df3ec0cdae79af379f4a10b802c50feac89ba";
    hash = "sha256-CH9GJnFqqdyIzW7VfGb3oB1YPULEZsfK3d1eyFALwKc=";
  };

  installPhase = ''
    mkdir -p $out/share/{plasma/look-and-feel,color-schemes}
    find . -type f -name "*.tar.gz" -exec tar -xzf "{}" \;
    find . -type f -name "Catppuccin*.colors" -exec cp "{}" $out/share/color-schemes \;
    cp -R Catppuccin-* $out/share/plasma/look-and-feel
  '';

  meta = with lib; {
    description = "🌻 Soothing pastel theme for KDE";
    homepage = "https://github.com/catppuccin/kde";
    license = licenses.mit;
    maintainers = with maintainers; [ michaelBelsanti ];
  };
}
