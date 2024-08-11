{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    defaults = {
      terminal = lib.mkOption {
        type = with lib.types; str;
      };

      #need to fix
      wallpaper = lib.mkOption {
        type = with lib.types; path;
      };

      launcher = lib.mkOption {
        type = with lib.types; str;
      };

      flake_dir = lib.mkOption {
        type = with lib.types; path;
        default = /home/${config.users.main}/.nixConfig;
      };

      cursor = lib.mkOption {
        description = "cursor module";
        type = with lib.types;
          submodule {
            options = {
              name = lib.mkOption {type = str;};
              size = lib.mkOption {type = int;};
              pkg = lib.mkOption {type = package;};
            };
          };
      };
    };
  };
}
