{ lib, pkgs, config, ... }:

{
  # system version
  system.stateVersion = "24.05"; # DO NOT CHANGE

  # networking, time, locales, that jazz
  networking.hostName = "goat-nixos"; 
  networking.networkmanager.enable = true; 
  time.timeZone = "America/Vancouver"; 
  i18n.defaultLocale = "en_US.UTF-8"; 

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

  # set a password with ‘passwd’
  users.mutableUsers = true;
  users.users.goat = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "lp" "libvirtd" ];
    shell = pkgs.bash;
    ignoreShellProgramCheck = true;
  };


}