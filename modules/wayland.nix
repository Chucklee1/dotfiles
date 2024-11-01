{ lib, pkgs, config, ... }: 

{
  # specific services
  services.gnome.gnome-keyring.enable = true;

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
    libnotify 
    libsecret 
    playerctl 
    pavucontrol 
    brightnessctl 
    # wayland
    wayland-utils
    egl-wayland 
    qt5.qtwayland 
    qt6.qtwayland
    wlogout 
    swayidle 
    swaylock-effects 
    waybar 
    swww
    dunst
    wtype 
    wl-clipboard 
    cliphist 
    xclip 
    grim 
    slurp
    # niri
    wayland-scanner 
    niri
    fuzzel 
    # hyprland
    hyprland-protocols
    hyprcursor
    hyprshot
    rofi-wayland
  ];

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.package = pkgs.lxqt.policykit;
    polkit.extraConfig = ''
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
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
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

