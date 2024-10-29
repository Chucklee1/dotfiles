{ config, pkgs, ... }:

{
  home.username = "goat";
  home.homeDirectory = "/home/goat";
  home.stateVersion = "24.05";
   
  gtk = {
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };
              
  programs = {
    kitty = {  
      enable = true;
      settings = {
		scrollback_lines = 2000;
		wheel_scroll_min_lines = 1;
        window_padding_width = 4;
		confirm_os_window_close = 0;
      };
      extraConfig = ''
		     tab_bar_style fade
		     tab_fade 1
		     active_tab_font_style   bold
		     inactive_tab_font_style bold
      '';
    };
    bash = {
      enable = true;
      shellAliases = {
        sv = "sudo nvim";
        v = "nvim";    
        cg = "sudo nix-collect-garbage";
        niri = "niri --session -c $HOME/goat/configs/config.kdl";
        update-desktop = "sudo nixos-rebuild switch --impure --flake ~/goat#desktop";
        udate-laptop = "sudo nixos-rebuild switch --impure --flake ~/goat#laptop";
      };
		};
 	};

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
