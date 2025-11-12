{ __findFile, ... }:
{
  den.aspects = {
    quasi.includes = [
      <nushell>
      <fish>
      <shell>
      <apps/coreutils>
    ];
    workstation.includes = [
      <dev>
      <apps/gui>

      <apps/distrobox>
      <apps/ghostty>
      <apps/git>
      <apps/jujutsu>
      <apps/halloy>
      <apps/helix>
      <apps/localsend>
      <apps/nh>
      <apps/nix-tools>
      <apps/radicle>
      <apps/topgrade>
      <apps/vicinae>
      <apps/wezterm>
      <apps/zen>
      <apps/zsa>
    ];
  };

}
