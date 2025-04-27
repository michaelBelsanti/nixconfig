let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {
    includes = [
      "${pins.nixos}/modules/nixos.nix"
      "${pins.unify}/unify.nix"
      ./inputs.nix
    ];
    config =
      {
        __module__.args.dynamic.pins = pins;
        lib = config.inputs.unify.result.lib;
        shells.default = {
          systems = [ "x86_64-linux" ];
          shell =
            { mkShell, system }:
            mkShell {
              packages = [ config.inputs.nilla-utils.packages.default.result.${system} ];
            };
        };
        unify.hosts =
          let
            hostDefaults = {
              user = "quasi";
              args = {
                inherit (config) inputs;
                nillaConfig = config;
                wrapper-manager = config.inputs.wrapper-manager.result;
              };
              type = "nixos";
              # system = "x86_64-linux";
              paths = [
                ./hosts
                ./modules
              ];
            };
          in
          {
            hades = hostDefaults;
            zagreus = hostDefaults;
          };
      };
  }
)
