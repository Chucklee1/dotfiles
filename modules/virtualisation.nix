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
                packages = [ (pkgs.OVMF.override {
                    tpmSupport = true;  # Keep TPM support if needed
                }).fd ];
            };
        };
    };
    
    programs.virt-manager.enable = true;

    environment.sessionVariables = {
        "GDK_BACKEND" = "wayland";
        "QT_QPA_PLATFORM" = "wayland";
    };
}