{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
