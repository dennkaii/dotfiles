{
  # config,
  inputs,
  pkgs,
  config,
  ...
}: let
  cfs = config.services;
in {
  config = {
    inputs.agenix.url = "github:ryantm/agenix";

    osModules = [
      inputs.agenix.nixosModules.default
    ];

    os.environment.systemPackages = [
      inputs.agenix.packages.${pkgs.system}.default
    ];

    # age.secrets = {
    #   searx-key = inputs.nyx.lib.mkAgenixSecret cfs.searxng.enable {
    #     file = "../../secrets/searx.age";
    #     mode = "400";
    #     owner = "searx";
    #     group = "searx";
    #   };
    # };
  };
}
