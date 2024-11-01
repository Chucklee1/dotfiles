{ lib, pkgs, config, ... }: 

{
  # specific services
  services = {
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };

  # programs/packages related to wayland
  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # global
    wayland-utils
    egl-wayland 
    qt5.qtwayland 
    qt6.qtwayland
    waybar 
    swww
    libnotify 
    dunst
    libsecret 
    lxqt.lxqt-policykit
    swayidle 
    swaylock-effects 
    wlogout 
    grim 
    slurp
    playerctl 
    pavucontrol 
    wtype 
    brightnessctl 
    wl-clipboard 
    cliphist 
    xclip 
    # niri
    wayland-scanner 
    niri
    fuzzel 
    # hyprland
    hyprland-scanner
    hyprland-protocols
    hyprcursor
    hyprshot
    rofi-wayland
  ];

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

  # xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}

