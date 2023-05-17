pkgs: rec {
  default = nix;
  nix = pkgs.mkShell {
    packages = with pkgs; [
      cachix
      statix
      vulnix
      deadnix
      nil      
    ];
  };
  rust = pkgs.mkShell {
    packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
    ];
  };
  c = pkgs.mkShell {
    packages = with pkgs; [
      gnumake
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
