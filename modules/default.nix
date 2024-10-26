{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    # global modules
    inputs.home-manager.nixosModules.default 
    # toggle modules
    ./nvidia.nix 
  ];
  
  # boot loader
  boot.loader = {
		grub.enable = true;
		grub.device = "nodev";
		grub.efiSupport = true;
		efi.canTouchEfiVariables = true;
		efi.efiSysMountPoint = "/boot";
	};  
  	
  # hostname
  networking.hostName = "goat"; 

  # networking
  networking.networkmanager.enable = true;

  # time zone.
  time.timeZone = "America/Vancouver";

  # locale
  i18n.defaultLocale = "en_CA.UTF-8";

  # services
  services= {
    # x11 
    xserver.enable = true;
    
    # hardware input
    libinput.enable = true; # laptop input
    xserver.xkb.layout = "us";
    xserver.xkb.variant = "";
    
    # printing
    printing.enable = true;
  };
  
  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
    

 
  # user account
  users.users.goat = {
    isNormalUser = true;
    description = "goat";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ neofetch sl firefox ];
  };
  
  home-manager."goat" = {
    extraSpecialArgs = { inerit inputs };
    users = {
      modules = [
        ../home.nix;
        inputs.self.outputs.homeManagerModules.default
      ];
    };
  };
  
  environment.systemPackages = with pkgs; [
    neovim wget git htop ripgrep
    papirus-icon-theme materia-theme arc-theme
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	# system version
  system.stateVersion = "24.05"; # DO NOT CHANGE
  # DO, NOT, CHANGE...

}
# notes
#
# module example
#
#  options = {
#    module.enable = libmkEnableOption "enables module";
#  };
#  
#    config = lib.mkIf config.module.enable {
#    option1 = true;
#    option2 = false;
#  };
#
#
#
#
#
#
#

