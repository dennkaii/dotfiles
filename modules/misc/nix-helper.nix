{
  inputs,
  ...
}:
{
  config = {
    inputs.nh.url = "github:viperML/nh";

    osModules = [
      inputs.nh.nixosModules.default
    ];

    os.environment.variables.FLAKE = "/home/dennkaii/.nixConfig";

    os.nh = {
    
      enable = true;
      
    };
  };
}
