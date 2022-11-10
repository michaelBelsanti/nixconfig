# nixconfig
My system and user config in a Nix Flake

This flake includes two NixOS configurations, one for my laptop and one for my desktop. It also includes a Darwin configuration (currently broken).

I hope this configuration can provide some useful examples! It's always a work in progress as I try to optimize it. Many aspects of it are heavily based off [Matthias Benaets config](https://github.com/MatthiasBenaets/nixos-config), be sure to check his out!

# Structure
The flake uses a very modular structure, allowing different configs to share as many lines of code and files as possible. 
- nixos - Contains options for NixOS configurations
  - configuration.nix, home.nix, nix.nix - Options that are used by both NixOS configurations.
  - desktop, laptop - Options specific to these configurations
- packages - All general use packages
  - Folders are used to sort the types of packages
  - nixos/{desktop, laptop} - These are the files imported by my NixOS configurations, they import other package files I want that configuration to have.
- modules - Options for specific applications, most of which require configuration files
  - Generally imported by a configuration.nix file, but some are only imported by home-manager
  - Some contain a config folder that is imported by home-manager 
- etc -  Random assets
- shells - General per language development shells (Very WIP)
