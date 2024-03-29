{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "markdown-oxide";
  version = "0.0.4";

  src = fetchFromGitHub {
    owner = "Feel-ix-343";
    repo = "markdown-oxide";
    rev = "v${version}";
    hash = "sha256-m7YOWoGcIM1Kvv1mzFQHiM9lN58JEw0DTsPuWTNw3fM=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "tower-lsp-0.20.0" = "sha256-QRP1LpyI52KyvVfbBG95LMpmI8St1cgf781v3oyC3S4=";
    };
  };

  meta = with lib; {
    description = "Let's record your consciousness! Bring your own text editor! Markdown-Oxide is Obsidian-Inspired PKM software for tech enthusiasts";
    homepage = "https://github.com/Feel-ix-343/markdown-oxide";
    license = licenses.cc0;
    maintainers = with maintainers; [ ];
    mainProgram = "markdown-oxide";
  };
}
