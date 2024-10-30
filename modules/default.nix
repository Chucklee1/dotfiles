{ lib, pkgs, config, inputs, ... }:

{
  imports =
  [
    ./nvidia.nix
    ./radeon.nix
    ./theming.nix
    ./wayland.nix
    ./niri.nix
    ./hyprland.nix
  ];

  # global modules
  wayland.enable = true;
  hyprland.enable = true;
  niri.enable = true;

  # boot loader
  boot.loader ={
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
  };
  
  # other boot stuff
  boot = {
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    # Appimage Support
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
    flatpak.enable = false;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
  };

  # multi-device printing
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  # flatpaks
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Optimization settings
  nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
  };

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
  
  nixpkgs.config.allowUnfree = true;
  users.mutableUsers = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.goat = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "lp" ];
    shell = pkgs.bash;
    ignoreShellProgramCheck = true;
  };

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
