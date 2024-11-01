{ lib, pkgs, config, inputs, ... }:

{
  imports =
  [
    ./nvidia.nix
    ./radeon.nix
    ./theming.nix
    ./wayland.nix
  ];

  # boot
  boot = {
    # grub boot
    loader ={
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      grub.enable = true;
      grub.efiSupport = true;
      grub.device = "nodev";
    };
    # use tmpfs instead of tmp
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    # appimage support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
  
  # tty settings
  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true; 
  
  # system stuff
  networking.hostName = "goat-nixos"; # host name
  networking.networkmanager.enable = true; # networking
  time.timeZone = "America/Vancouver"; # time zone
  i18n.defaultLocale = "en_US.UTF-8"; # locales

  # divider go here
  services = {
    xserver = {
      enable = false;
      xkb.layout = "us";
      xkb.variant = "";
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # printing 
  services.printing.enable = true;

  # Optimization settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
  };

  # divider go here
  programs = {
    firefox.enable = false;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.goat = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "lp" ];
    shell = pkgs.bash;
    ignoreShellProgramCheck = true;
  };

  # divider go here
  environment.systemPackages = with pkgs; [
    lm_sensors yad duf ncdu wget git ripgrep killall pciutils appimage-run
    unrar unzip file-roller tree p7zip
    neovim networkmanagerapplet  
    geany gimp 
    mpv imv ffmpeg v4l-utils
    wev ydotool
    neofetch 
    pkg-config nixfmt-rfc-style
  ];
  
  # system version
  system.stateVersion = "24.05"; # DO NOT CHANGE

}
