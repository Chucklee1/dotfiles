{ lib, pkgs, config, ... }:

{
  # divider 
  services = {
    xserver = {
      enable = false;
      xkb.layout = "us";
      xkb.variant = "";
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
  };

  # sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # bluetooth 
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # printing 
  services.printing.enable = true;
}