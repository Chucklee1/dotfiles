{ lib, pkgs, config, ... }:

{
    boot.kernelParams = [ "amd_iommu=on" ];

    virtualisation.libvirtd = {
    enable = true;
    qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
            tpmSupport = true;
        }).fd];
        };
    };
    };
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    environment.systemPackages = [ 
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
    environment.sessionVariables = {
        "GDK_BACKEND" = "wayland";
        "QT_QPA_PLATFORM" = "wayland";
    };
}