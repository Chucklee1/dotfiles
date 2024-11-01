{ lib, pkgs, config, ... }: 

{
  # lazy theming
  stylix = {
    enable = true;
    # needed option, just ensure the image exist
    image = /home/goat/goat/configs/wallpapers/image.jpg;
    # actual color scheme
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