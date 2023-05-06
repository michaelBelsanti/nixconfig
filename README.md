# nixconfig
My system and user config in a Nix Flake

This flake includes two NixOS configurations, one for my laptop and one for my desktop. It also includes a home-manager configuration for my server. Flake-parts is used to increase modularity and simplify per-system outputs.

# Structure
The flake uses a very modular structure, allowing different configs to share as many lines of code and files as possible. 
- nixos: Contains configurations for NixOS Hosts
- home: Contains home-manager configurations to use on any system
- overlay.nix: overlay that modifies, inherits, and adds packages

# Inspiration
- [MatthiasBenaets/nixos-config](https://github.com/MatthiasBenaets/nixos-config): My first flake was completely based of this and has since evolved many times over, an amazing repo to learn from
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles): Inspired my most recent restructuring, basically a better and more interesting version of mine