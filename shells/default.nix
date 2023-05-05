{ pkgs, ... }:
{
  rust = pkgs.mkShell {
    packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
    ];
  };
  c = pkgs.mkShell {
    packages = with pkgs; [
      make
      gcc
      clang-tools # For clangd
    ];
  };
  haskell = pkgs.mkShell {
    packages = with pkgs; [
      ghc
      haskell-language-server
    ];
  };
  python = pkgs.mkShell {
    packages = with pkgs; [
      python3
      # python311Packages.venvShellHook
    ];
  };
}
