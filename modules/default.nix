{ lib, pkgs, config, inputs, ... }:

{
  imports =
  [
    ./nvidia.nix
    ./radeon.nix
  ];

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
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = "goat";
      dataDir = "/home/goat";
      configDir = "/home/goat/.config/syncthing";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
  };
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

    hardware.graphics.enable = true;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Optimization settings
  nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs = {
    firefox.enable = false;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
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

  stylix = {
    enable = true;
    image = /home/goat/goat/configs/wallpapers/clouds-sunset.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ocean.yaml";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";
    cursor.size = 24;
  };

  environment.systemPackages = with pkgs; [
    # utils
    lm_sensors yad duf ncdu wget git ripgrep killall pciutils appimage-run
    
    # archive/file management
    unrar unzip file-roller tree p7zip
    
    # goeys
    neovim networkmanagerapplet  
    
    # general apps 
    geany gimp 
    
    # media support
    mpv imv ffmpeg v4l-utils
    
    # wayland
    niri wayland-scanner wayland-utils egl-wayland fuzzel waybar swww
    
    # qt wayland support
    qt5.qtwayland qt6.qtwayland
    
    # security
    libsecret swayidle swaylock-effects wlogout lxqt.lxqt-policykit
     
    # screenshots
    grim slurp 
    
    # clipboard
    wl-clipboard cliphist xclip 

    # key inputs and control
    wtype wev ydotool brightnessctl playerctl pavucontrol  
    
    # notifications 
    libnotify  dunst neofetch 
    
    # paxs
    pkg-config nixfmt-rfc-style
  ];

  # fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };

  # xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
  
  # system version
  system.stateVersion = "24.05"; # DO NOT CHANGE

}
