let
  combinedManager = import (builtins.fetchTarball {
    url = "https://github.com/flafydev/combined-manager/archive/71d2bc7553b59f69315328ba31531ffdc8c3ded2.tar.gz";
    sha256 = "sha256:0dkjcy3xknncl4jv0abqhqspnk91hf6ridb5xb7da5f29xn60mnf";
  });
in
  combinedManager.mkFlake {
    description = "yet another another flake oml";

    lockFile = ./flake.lock;

    initialInputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      flake-parts.url = "github:hercules-ci/flake-parts";
      devshell.url = "github:numtide/devshell";
    };

    configurations = {
      Aethyr = {
        system = "x86_64-linux";
        modules = [
          ./modules
          ./hosts/Aethyr
          ./configs/dennkaii
        ];
      };
    };

    outputs = inputs @ {flake-parts, ...}:
      flake-parts.lib.mkFlake {inherit inputs;} {
        imports = [
          inputs.devshell.flakeModule
        ];
        systems = [
          "x86_64-linux"
        ];
        perSystem = {pkgs, ...}: {
          formatter = pkgs.alejandra;

          devshells.start_page = {
            env = [
              {
                name = "HTTP_PORT";
                value = 3000;
              }
            ];
            commands = [
              {
                help = "Install dependencies";
                name = "yarn-install";
                command = "yarn";
              }
            ];
            packages = with pkgs; [
              nodejs_21
              yarn
            ];
          };

          # pkgs = import ./pkgs {inherit pkgs;};
        };
      };
  }
# TOOK as reference
# https://github.com/n3oney/nixus/blob/main/flake.nix
# https://github.com/FlafyDev/nixos-config/blob/main/flake.nix

