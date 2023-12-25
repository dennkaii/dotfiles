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

  config = mkIf {
    users.groups = ["libvirtd"];

    os = {
      virtualization.libvirtd.enable = true;
      programs.virt-maanger.enable = true;


      programs.dconf.enable = true;

      
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
        };
      };
    };
  };
}
