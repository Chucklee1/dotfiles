{ lib, pkgs, config, ... }:

{
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    programs.dconf.enable = true;

    dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
    };

    enviorment.systemPackages = [ 
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };
}