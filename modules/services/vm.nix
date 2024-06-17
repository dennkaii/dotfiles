{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.vm;
  inherit (lib) mkIf mkEnableOption;
in {
  options.vm = {
    enable = mkEnableOption "vm";
  };

  config = mkIf cfg.enable {
    users.groups = ["libvirtd"];

    hm = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };

    os = {
      virtualisation = {
        # vmware.host.enable = true;
        libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            swtpm.enable = true;
            ovmf.enable = true;
            ovmf.packages = [pkgs.OVMFFull.fd];
          };
        };
        spiceUSBRedirection.enable = true;
      };

      programs.virt-manager.enable = true;

      programs.dconf.enable = true;
    };
  };
}
