{
  pkgs,
  inputs,
  lib,
  ...
}: {
  inputs.helix.url = "github:helix-editor/helix";

  hm = {
    home.sessionVariables.EDITOR = "hx";

    programs.helix = {
      enable = true;

      package = inputs.helix.packages.${pkgs.system}.default;

      settings = {
        # theme = "rose_pine_moon";
        # icons = "nerdfonts";

        editor = {
          true-color = true;
          cursorline = true;
          mouse = true;
          completion-replace = true;
          auto-save = true;
          color-modes = true;
          idle-timeout = 1;
          # indent-guides.render = true;
          # rulers = [80];
          cursor-shape = {
            insert = "bar";
            select = "block";
            normal = "block";
          };
          lsp = {
            display-inlay-hints = true;
          };
        };

        # cursor-shape = {
        #   insert = "bar";
        # };
      };

      languages = {
        language-server = {
          #stolen from n3oney
          typescript-language-server = {
            command = lib.getExe pkgs.nodePackages.typescript-language-server;
            args = ["--stdio"];
            config.hostInfo = "helix";
            config.documentFormatting = false;
          };
          vscode-css-language-server = {
            command = lib.getExe pkgs.nodePackages.vscode-css-languageserver-bin;
            args = ["--stdio"];
            config.provideFormatter = true;
          };

          nil = {
            command = lib.getExe pkgs.nil;
            config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
          };
        };
      };
    };
  };
}
