{ config, pkgs, ... }:

{
  home.username = "goat";
  home.homeDirectory = "/home/goat";

  # DO NOT CHANGE
  home.stateVersion = "24.05"; 

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [];

  home.file = {};
  
  home.sessionVariables = {
    EDITOR = "neovim";
  };
  
      programs.bash = {
    	enable = true;
    	shellAliases = {
    	nixdir = "/home/goat/zeige/";
    	}; 
    }; # bash

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
#
#
#
#
