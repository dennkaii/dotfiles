{
  # config,
  inputs,
  ...
}: {
  inputs.agenix.url = "github:ryantm/agenix";

  osModules = [inputs.agenix.nixosModules.default];
}
