{ lib, config, ... }:
# laptop conf
{
  imports =
  [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ]; 
  
  nvidia.enable = false;
  radeon.enable = true; 
}
