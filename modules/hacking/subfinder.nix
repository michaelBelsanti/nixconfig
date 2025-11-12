{
  den.aspects.hax._.subfinder.homeManager =
    { lib, config, ... }:
    {
      sops.secrets = {
        shodan_api_key = { };
        certspotter_api_key = { };
        chaos_api_key = { };
        fofa_api_key = { };
        virustotal_api_key = { };
      };
      sops.templates."subfinder-providers.yaml".content = lib.generators.toYAML { } {
        shodan = [ config.sops.placeholder.shodan_api_key ];
        certspotter = [ config.sops.placeholder.certspotter_api_key ];
        chaos = [ config.sops.placeholder.chaos_api_key ];
        fofa = [ config.sops.placeholder.fofa_api_key ];
        virustotal = [ config.sops.placeholder.virustotal_api_key ];
      };
    };
}
