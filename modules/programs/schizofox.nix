{
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.programs.schizofox;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.schizofox = {
    enable = mkEnableOption "schizofox";
  };

  config = mkIf cfg.enable {
    inputs = {schizofox.url = "github:schizofox/schizofox";};

    hmModules = [inputs.schizofox.homeManagerModules.default];

    hm = {
      #TODO declarative config
      programs.schizofox = {
        enable = true;

        security = {
          sanitizeOnShutdown = false;
          sandbox = true;
        };
        search = {
          defaultSearchEngine = "Kagi";
          removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
          addEngines = [
            {
              name = "Kagi";
              alias = "kagi";
              URLTemplate = "https://kagi.com/search?q=%s";
            }
          ];
        };
      };
    };
  };
}
