{ lib, config, ... }:
# desktop conf
{
  imports =
  [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ]; 
  
  nvidia.enable = true;
  radeon.enable = false;

}
