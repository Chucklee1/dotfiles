{ lib, pkgs, config, ... }: 

{
  # lazy theming
  stylix = {
    enable = true;
    image = /home/goat/goat/configs/wallpapers/clouds-sunset.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ocean.yaml";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";
    cursor.size = 24;
  };

  # fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}