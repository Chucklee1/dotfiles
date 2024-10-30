{ lib, pkgs, config, ... }: 

{
  options = {
    niri.enable = lib.mkEnableOption "enables niri wm";
  };

  config = lib.mkIf.config.module1.enable {

    # because rofi-wayland does not work well with niri
    environment.systemPackages = with pkgs; [
      niri
      fuzzel 
    ];
    
    # xdg portal
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };
  };
}