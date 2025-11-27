{ __findFile, ... }:
{
  den.aspects.quasi.includes = [
    <styx/fish>
    <styx/apps/coreutils>
  ];
  styx.workstation.includes = [
    <styx/dev>
    <styx/apps/gui>
    <styx/apps/distrobox>
    <styx/apps/ghostty>
    <styx/apps/git>
    <styx/apps/jujutsu>
    <styx/apps/halloy>
    <styx/apps/localsend>
    <styx/apps/nh>
    <styx/apps/nix-tools>
    <styx/apps/radicle>
    <styx/apps/topgrade>
    <styx/apps/vicinae>
    <styx/apps/wezterm>
    <styx/apps/zen>
    <styx/apps/zsa>
  ];
}
