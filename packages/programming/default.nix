{ pkgs
, lib
, rust ? true
, java ? false
, ...
}:

let
  rustPkgs = pkgs: with pkgs; [ rustc cargo gcc rust-analyzer taplo ];
  javaPkgs = pkgs: with pkgs; [ jetbrains.idea-community jdk11 ];
in

{
  # inherit rustSupport javaSupport;
  home.packages = with pkgs; [ lldb so ]
    ++ rustPkgs pkgs
    ++ javaPkgs pkgs;
  # ++ lib.optional rust rustPkgs pkgs
  # ++ lib.optional java javaPkgs pkgs;
}
