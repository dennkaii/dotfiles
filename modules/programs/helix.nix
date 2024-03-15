{
  pkgs,
  inputs,
  lib,
  ...
}: {
  inputs.helix.url = "github:helix-editor/helix";

  hm = {
    home.sessionVariables.EDITOR = "hx";

    home.packages = with pkgs; [
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-langservers-extracted
      nodePackages.prettier
      
    ];
    programs.helix = {
      enable = true;

      package = inputs.helix.packages.${pkgs.system}.default.overrideAttrs (self: {
        makeWrapperArgs = with pkgs;
        self.makeWrapperArgs 
        or []
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath[
            clang-tools
              marksman
              nil
              luajitPackages.lua-lsp
              nodePackages.bash-language-server
              nodePackages.vscode-css-languageserver-bin
              nodePackages.vscode-langservers-extracted
              nodePackages.prettier
              rustfmt
              rust-analyzer
              black
              alejandra
              shellcheck
          ])
        ];
      });

      settings = {
        # theme = "rose_pine_moon";
        # icons = "nerdfonts";

        editor = {
          true-color = true;
          cursorline = true;
          mouse = false;
          completion-replace = true;
          auto-format = true;
          auto-save = true;
          auto-info = true;
          color-modes = true;
          idle-timeout = 1;
           indent-guides.render = true;
           rulers = [100];
          cursor-shape = {
            insert = "bar";
            select = "block";
            normal = "block";
          };
          lsp = {
            display-inlay-hints = true;
            display-messages = true;
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
