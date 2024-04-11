{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.programs.radicle;
in {
  options.programs.radicle.enable = lib.mkEnableOption "radicle";

  config = lib.mkIf cfg.enable {
    inputs.heartwood = {
      url = "git+https://seed.radicle.xyz/z3gqcJUoA1n9HaHKufZs5FCSGazv5.git?ref=master&rev=77076af23c9cbbf124755f3737d523a77a5bb534";
    };
    os.environment.systemPackages = [
      inputs.heartwood.packages.${pkgs.hostPlatform.system}.radicle-full
      # radicle-upstream
    ];
  };
}
