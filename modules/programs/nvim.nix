{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:let
cfg = config.programs.neovim;
inherit(lib) mkEnableOption mkIf;
in {
  options.programs.neovim.enable = mkEnableOption "neovim flake";

  config = mkIf cfg.enable{
    inputs = {
      neovim-flake = {

        url = "github:notashelf/neovim-flake";
        inputs.nixpkgs.follows = "nixpkgs";
        
      };
    };

    hmModules = [inputs.neovim-flake.homeManagerModules.default];

    hm.home.packages = [
      inputs.neovim-flake.packages.${pkgs.hostPlatform.system}.maximal      
    ];
     };
}
