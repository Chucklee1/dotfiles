{ lib, pkgs, config, ... }:

{
  # divider go here
  programs = {
    firefox.enable = false;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  # divider go here
  environment.systemPackages = with pkgs; [
    lm_sensors yad duf ncdu wget git ripgrep killall pciutils appimage-run
    unrar unzip file-roller tree p7zip
    neovim networkmanagerapplet  
    geany gimp 
    mpv imv ffmpeg v4l-utils
    wev ydotool
    neofetch 
    pkg-config nixfmt-rfc-style
  ];
}