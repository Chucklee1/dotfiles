{ lib, pkgs, config, inputs, ... }:

{
  imports = [
    ./GPU/nvidia.nix
    ./GPU/radeon.nix
    ./infrastructure.nix # hardware & services
    ./software.nix # progams and enviorment packages
    ./theming.nix
    ./virtualisation.nix
    ./wayland.nix
  ];

  # system version
  system.stateVersion = "24.05"; # DO NOT CHANGE

  # boot loader (currently using grub)
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
  };

  # use tmpfs instead of tmp
  boot.tmp.useTmpfs = false; 
  boot.tmp.tmpfsSize = "30%";
  
  # appimage support
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # tty settings
  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true; 

  # nix 
  nixpkgs.config.allowUnfree = true;
  nix.settings = { # Optimization settings
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # networking, time, locales, that jazz
  networking.hostName = "goat"; 
  networking.networkmanager.enable = true; 
  time.timeZone = "America/Vancouver"; 
  i18n.defaultLocale = "en_US.UTF-8"; 

  # set a password with ‘passwd’
  users.mutableUsers = true;
  users.users.goat = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "lp" "libvirtd" ];
    shell = pkgs.bash;
    ignoreShellProgramCheck = true;
  };
}
