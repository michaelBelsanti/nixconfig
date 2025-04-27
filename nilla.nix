let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {
    includes = [
      "${pins.nilla-utils}/modules/nixos.nix"
      "${pins.unify}/unify.nix"
      ./inputs.nix
    ];
    config =
      let
        inputs = builtins.mapAttrs (name: value: value.result) config.inputs;
      in
      {
        __module__.args.dynamic.pins = pins;
        lib = inputs.unify.lib;
        shells.default = {
          systems = [ "x86_64-linux" ];
          shell =
            { mkShell, system }:
            mkShell {
              packages = [ inputs.nilla-utils.packages.default.result.${system} ];
            };
        };
        unify.hosts =
          let
            hostDefaults = {
              args = {
                inherit inputs;
                nillaConfig = config;
                wrapper-manager = inputs.wrapper-manager;
              };
              type = "nixos";
              system = "x86_64-linux";
              paths = [
                ./hosts
                ./modules
                ./rices
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
