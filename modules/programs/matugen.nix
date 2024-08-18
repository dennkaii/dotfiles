{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.programs.matugen;
in {
  options.programs.matugen.enable = lib.mkEnableOption "matugen";

  config = lib.mkIf cfg.enable {
    inputs.matugen.url = "github:Theaninova/matugen/add-home-manager-module";
  };
}
