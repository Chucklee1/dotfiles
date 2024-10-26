{ lib, config, pkgs, ... }: 

{
  
  options = {
    nvidiaGPU.enable = libmkEnableOption "enable nvidia drivers";
  };
  
    config = lib.mkIf config.nvidiaGPU.enable {
    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  
}
