{ config, lib, pkgs, ... }:

{
  home.username = "goat";
  home.homeDirectory = "/home/goat";
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [ hyprscroller ];
  }; 
  
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # DO NOT CHANGE
  home.stateVersion = "24.05"; 
}
