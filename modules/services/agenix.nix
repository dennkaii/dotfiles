{
  config,
  inputs,
  ...
}:
{

  config = { 
   inputs.agenix.url = "github:ryantm/agenix";

  osMoudles = [
    inputs.agenix.nixosModules.default
    ];
  };
}
