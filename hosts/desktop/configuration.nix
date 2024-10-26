{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];
  
  nvidiaGPU.enable = true;
}
