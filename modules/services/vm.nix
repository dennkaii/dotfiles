{
  config,
  lib,
  ...
}:let
cfg = config.vm;
inherit(lib) mkIf mkEnableOption;
in{
  options.vm = {
    enable  = mkEnableOption "vm";
  };

  config = mkIf cfg.enable{
    users.groups = ["libvirtd"];

    hm  = {       
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
          };
        };
      };

    os = {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
      
      virtualisation.spiceUSBRedirection.enable = true;

      programs.dconf.enable = true;
    };
  };
}
