{ lib, pkgs, config, ... }: 

{
  options = {
    wayland.enable = lib.mkEnableOption "enables wayland options";
  };

  config = lib.mkIf.config.module1.enable {

    # opengl - called graphics as of 24.11 smth
    hardware.graphics.enable = true;

    # specific services
    services = {
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
    };

    # programs/packages related to wayland
    programs = {
      conf.enable = true;
      seahorse.enable = true;
      fuse.userAllowOther = true;
      mtr.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    environment.systemPackages = with pkgs; [
      wayland-scanner 
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

    # xdg portals defined in specific wm

  };
}

