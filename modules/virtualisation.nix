{ lib, pkgs, config, ... }:

{
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    programs.dconf.enable = true;
    programs.dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
};
}