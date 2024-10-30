{ lib, pkgs, config, ... }: 

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland wm";
  };

  config = lib.mkIf.config.module1.enable {

    # xwayland support :)
    programs.hyprland = {
      enable = true;
      xwayland = true;
    };

    # xdg portal
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal
      ];
    };
  };
}