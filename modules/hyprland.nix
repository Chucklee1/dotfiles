{ pkgs, config, lib, ... }
{
  options = {
    hyprland.enable = libmkEnableOption "enables hyprland window manager";
  };
  
  config = lib.mkIf config.module.enable {
    # hyprland
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
  };
  
  environment.systemPackages = with pkgs; [
    swww 
    waybar 
    rofi-wayland 
    kitty
    dunst 
  ];

}
