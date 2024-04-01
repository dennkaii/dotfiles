{
  config, 
  lib,
  ...
}:let
cfg = config.services.docker;
in {

options.services.docker.enable = lib.mkEnableOption "docker";

config = lib.mkIf cfg.enable{
  users.groups = ["docker"];

  os = {
    virtualisation.docker.enable = true;
  };
};
}
