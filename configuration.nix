{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  # Bootloader
  boot.loader = {
		grub.enable = true;
		grub.device = "nodev";
		grub.efiSupport = true;
		efi.canTouchEfiVariables = true;
		efi.efiSysMountPoint = "/boot";
	};

  # Define hostname
  networking.hostName = "goat"; 

	# enable nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # X11
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # user
  users.users.goat = {
    isNormalUser = true;
    description = "goat";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox neofetch ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

	# env packages
  environment.systemPackages = with pkgs; [
		neovim git htop ripgrep
		# swww rofi-wayland waybar  
		# mpv gnome.file-roller
  ];

  # budie desktop
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  # DO NOT CHANGE
  system.stateVersion = "24.05"; 

}
