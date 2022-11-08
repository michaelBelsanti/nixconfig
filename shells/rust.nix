{ pkgs }:

pkgs.mkShell rec {
  # include any libraries or programs in buildInputs
  buildInputs = with pkgs; [
    rustc
    cargo
    gcc
    rust-analyzer
    taplo
  ];

  # shell commands to be ran upon entering shell
  shellHook = ''
  '';
}
