{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:{
  inputs.helix.url = "github:helix-editor/helix";

  hm = {
    home.sessionVariables.EDITOR = "hx";

    programs.helix = {
      enable = true;

      package = inputs.helix.packages.${pkgs.system}.default;

      settings = {
        # theme = "rose_pine_moon";

         editor = {
          true-color = true;
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
          nil.command = lib.getExe pkgs.nil;
          eslint = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
            args = ["--stdio"];
            config = {
              validate = "on";
              experimental.useFlatConfig = false;
              rulesCustomizations = [];
              run = "onType";
              problems.shortenToSingleLine = false;
              nodePath = "";
              codeAction.disableRuleComment = {
                enable = true;
                location = "separateLine";
              };

              codeActionOnSave = {
                enable = true;
                mode = "fixAll";
              };

              workingDirectory.mode = "location";
            };
          };  
        };
      };
    };
  };
}
