self: super: {
  discord-openasar = super.discord.override { 
    nss = super.nss_latest; withOpenASAR = true;
  };
}