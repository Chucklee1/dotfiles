{ config, pkgs, ... }:

{
  home.username = "goat";
  home.homeDirectory = "/home/goat";
  home.stateVersion = "24.05";
   
  gtk = {
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };
  
  home.packages = with pkgs; [
    cmatrix lolcat htop cowsay 
	  vscode-fhs spotify firefox msgviewer
	  libgccjit rustc
  ];

  # virtualization
  dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};

              
  programs = {
	git = {
	  enable = true;
    # use your own email and username
	  userEmail = "cooperkang4@gmail.com";
	  userName = "Chucklee1";
	};
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
        update-desktop = "sudo nixos-rebuild switch --flake ~/goat#desktop --impure --show-trace";
        update-laptop = "sudo nixos-rebuild switch --flake ~/goat#laptop --impure --show-trace";
      };
		};
 	};

  home.sessionVariables = {
    EDITOR = "neovim";
	  NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # disable window decoration for qt apps 
    SDL_VIDEODRIVER = "wayland"; 
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    CLUTTER_BACKEND = "wayland";
    GTK_CSD = "true";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
