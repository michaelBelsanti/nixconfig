{ stdenv, fetchgit, pkgs }:
{
  sugar-candy = stdenv.mkDerivation rec {
    pname = "sddm-sugar-candy";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-candy
    '';
    src = fetchgit {
      url = "https://framagit.org/MarianArlt/sddm-sugar-candy.git";
      rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
      sha256 = "sha256-XggFVsEXLYklrfy1ElkIp9fkTw4wvXbyVkaVCZq4ZLU=";
    };    
  };
}
