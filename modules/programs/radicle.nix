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
      url = "git+https://seed.radicle.xyz/z3gqcJUoA1n9HaHKufZs5FCSGazv5.git?ref=refs/namespaces/z6MksFqXN3Yhqk8pTJdUGLwATkRfQvwZXPqR2qMEhbS9wzpT/refs/tags/v1.0.0-rc.8";
    };
    os.environment.systemPackages = [
      inputs.heartwood.packages.${pkgs.hostPlatform.system}.radicle-full
      # radicle-upstream
    ];
  };
}
