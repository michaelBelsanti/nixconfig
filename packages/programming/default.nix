{ pkgs, ... }:
let
  rustPkgs = with pkgs; [ rustc cargo gcc rust-analyzer taplo clippy ];
  haskellPkgs = with pkgs; [ ghc haskell-language-server ];
in
{
  # inherit rustSupport javaSupport;
  home.packages = with pkgs; [ lldb so ]
    ++ rustPkgs
    ++ haskellPkgs;
}
