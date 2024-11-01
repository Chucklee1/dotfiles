{ lib, pkgs, config, inputs, ... }:

{
  imports =
  [
    ./boot.nix
    ./system-config.nix # locales, time, user, nix, & system
    ./GPU/nvidia.nix
    ./GPUradeon.nix
    ./infrastructure.nix # hardware & services
    ./software.nix # progams and enviorment packages
    ./theming.nix
    ./virtualisation.nix
    ./wayland.nix
  ];
}
