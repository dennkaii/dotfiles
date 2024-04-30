{
  inputs,
  config,
  ...
}: {
  config = {
    inputs.nh.url = "github:viperML/nh";

    osModules = [
      inputs.nh.nixosModules.default
    ];

    os.environment.variables.FLAKE = "/home/${config.users.main}/.nixConfig";

    os.nh = {
      enable = true;
    };
  };
}
