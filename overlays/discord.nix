(final: prev: {
  discord = prev.discord.overrideAttrs (_: {
    withOpenASAR = true;
  });
})
