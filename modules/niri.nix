{ lib, pkgs, config, ... }: 

{
  options = {
    niri.enable = lib.mkEnableOption "enables niri wm";
  };

  config = lib.mkIf config.niri.enable {

    environment.systemPackages = with pkgs; [
      wayland-scanner 
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