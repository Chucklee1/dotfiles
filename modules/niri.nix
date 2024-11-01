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
  };
}