{
  lib,
  config,
  # keys,
  ...
}: let
  cfg = config.users;
  inherit (lib) mkOption types;
in {
  options.users = {
    main = mkOption {
      type = with types; str;
      description = ''
        List of package names that are allowed to be installed dispite being unfree.
      '';
    };

    groups = mkOption {
      type = with types; listOf str;
      default = [];
      description = ''
        Extra groups the main user will be apart of.
      '';
    };
  };

  config = {
    os = {
      users.users.root = {
        group = "root";
        hashedPassword = "$6$Zph0AgVL/4E0MTzN$xT4licArTl4ZHjUhQx.V87t3qoLGVZNucqhCH4h/UYx7gcDH6eTNb/dpJBvApl1dyTPgERf7Hu1w1HkVlKSJf/";
        isSystemUser = true;
      };

      users.users.${cfg.main} = {
        uid = 1000;
        hashedPassword = "$6$2kijaBST13rqrL2T$5rlGqmTrB.cYdKttgxbESHh3Oda0cCAfA.u6Qxh/gL1SaW9QpzVje58y1Xayrs6aA6quUfdpXC.jNpTzSG0bH1";
        isNormalUser = true;
        # openssh.authorizedKeys.keys = [keys.dennkaii];
        extraGroups =
          [
            "wheel"
            "video"
            "networkmanager"
            "audio"
            "pipewire"
          ]
          ++ cfg.groups;
      };
      users.mutableUsers = false;
    };
    hmUsername = cfg.main;
  };
}
