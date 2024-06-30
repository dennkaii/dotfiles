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

      defaultEditor = true;

      package = inputs.helix.packages.${pkgs.system}.default.overrideAttrs (self: {
        makeWrapperArgs = with pkgs;
          self.makeWrapperArgs
          or []
          ++ [
            "--suffix"
            "PATH"
            ":"
            (lib.makeBinPath [
              clang-tools
              markdown-oxide
              ltex-ls
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
              zig
              zls
            ])
          ];
      });

      settings = {
        theme = "oxocarbon";

        editor = {
          true-color = true;
          cursorline = true;
          mouse = false;
          completion-replace = true;
          completion-timeout = 5;
          completion-trigger-len = 2;
          bufferline = "multiple";
          auto-format = true;
          auto-save = true;
          auto-info = true;
          color-modes = true;
          idle-timeout = 250;
          indent-guides.render = true;
          rulers = [100];
          gutters = ["diff" "line-numbers" "spacer" "diagnostics"];
          cursor-shape = {
            insert = "bar";
            select = "block";
            normal = "block";
          };
          lsp = {
            display-inlay-hints = true;
            display-messages = true;
          };
          statusline = {
            left = ["mode" "spinner" "file-name" "file-modification-indicator"];
            center = ["diagnostics" "workspace-diagnostics"];
            right = ["position" "spacer" "file-type"];
          };
        };

        # cursor-shape = {
        #   insert = "bar";
        # };
      };

      themes = {
        oxocarbon = let
          base00 = "#161616";
          base01 = "#262626";
          base02 = "#393939";
          base03 = "#525252";
          base04 = "#dde1e6";
          base05 = "#f2f4f8";
          base06 = "#ffffff";
          base07 = "#08bdba";
          base08 = "#3ddbd9";
          base09 = "#be95ff";
          base0A = "#ee5396";
          base0B = "#33b1ff";
          base0C = "#ff7eb6";
          base0D = "#42be65";
          base0E = "#78a9ff";
          base0F = "#82cfff";
        in {
          "ui.background" = {bg = base00;};
          "ui.virtual.whitespace" = base03;
          "ui.menu" = {
            fg = base05;
            bg = base01;
          };
          "ui.menu.selected" = {
            fg = base01;
            bg = base04;
          };
          "ui.linenr" = {
            fg = base03;
            bg = base00;
          };
          "ui.popup" = {bg = base01;};
          "ui.window" = {bg = base01;};
          "ui.linenr.selected" = {
            fg = base04;
            bg = base01;
            modifiers = ["bold"];
          };
          "ui.selection" = {bg = base02;};
          "comment" = {
            fg = base03;
            modifiers = ["italic"];
          };
          "ui.statusline" = {
            fg = base04;
            bg = base01;
          };
          "ui.cursor" = {
            fg = base04;
            modifiers = ["reversed"];
          };
          "ui.cursor.primary" = {
            fg = base05;
            modifiers = ["reversed"];
          };
          "ui.text" = base05;
          "operator" = base0B;
          "ui.text.focus" = base05;
          "variable" = base04;
          "constant.numeric" = base09;
          "constant" = base09;
          "attribute" = base09;
          "type" = base07;
          "ui.cursor.match" = {
            fg = base0A;
            modifiers = ["underlined"];
          };
          "string" = base09;
          "variable.other.member" = base04;
          "constant.character.escape" = base0C;
          "function" = base0A;
          "constructor" = base0D;
          "special" = base0D;
          "keyword" = base0E;
          "label" = base08;
          "namespace" = base0E;
          "punctuation" = base08;
          "ui.help" = {
            fg = base06;
            bg = base01;
          };

          "markup.heading" = base0D;
          "markup.list" = base08;
          "markup.bold" = {
            fg = base0A;
            modifiers = ["bold"];
          };
          "markup.italic" = {
            fg = base0E;
            modifiers = ["italic"];
          };
          "markup.link.url" = {
            fg = base09;
            modifiers = ["underlined"];
          };
          "markup.link.text" = base08;
          "markup.quote" = base0C;
          "markup.raw" = base0B;

          "diff.plus" = base0B;
          "diff.delta" = base09;
          "diff.minus" = base08;

          "diagnostic" = {
            modifiers = ["underlined"];
            underline = {
              color = base0A;
              style = "curl";
            };
          };
          "ui.gutter" = {bg = base00;};
          "info" = base0D;
          "hint" = base03;
          "debug" = base03;
          "warning" = base09;
          "error" = base0A;

          "ui.bufferline" = {
            fg = base04;
            bg = base00;
          };
          "ui.bufferline.active" = {
            fg = base06;
            bg = base01;
          };
          "ui.statusline.normal" = {
            bg = base0F;
            fg = base00;
          };
          "ui.statusline.insert" = {
            bg = base0A;
            fg = base00;
          };
          "ui.statusline.select" = {
            bg = base0D;
            fg = base00;
          };
        };
      };

      languages = {
        language = let
          withLangServers = lang: servers:
            lang
            // {
              language-servers = (lang.language-servers or []) ++ servers;
            };
          mkPrettier = name: ext: {
            inherit name;
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["file.${ext}"];
            };
          };
        in [
          # {
          # name = "markdown";
          # auto-format = true;
          # language-servers = ["markdown-oxide" "ltex-ls"];
          # }

          {
            name = "nix";
            auto-format = true;
            formatter = {command = lib.getExe pkgs.alejandra;};
            roots = ["flake.nix"];
          }
          {
            name = "html";
            auto-format = true;
            language-servers = ["emmet-ls" "vscode-html-server"];
          }
          (withLangServers (mkPrettier "markdown" "md") ["markdown-oxide" "emmet-ls" "ltex-ls"])
        ];

        language-server = {
          ltex-ls = {
            command = lib.getExe pkgs.ltex-ls;
          };
          emmet-ls = {
            command = lib.getExe pkgs.emmet-language-server;
            args = ["--stdio"];
          };
          markdown-oxide = {
            command = lib.getExe pkgs.markdown-oxide;
          };
          #stolen from n3oney
          typescript-language-server = {
            command = lib.getExe pkgs.nodePackages.typescript-language-server;
            args = ["--stdio"];
            config.hostInfo = "helix";
            config.documentFormatting = false;
          };

          vscode-langservers-extracted = {
            command = lib.getExe pkgs.nodePackages.vscode-langservers-extracted;
          };

          vscode-css-language-server = {
            command = lib.getExe pkgs.nodePackages.vscode-css-languageserver-bin;
            args = ["--stdio"];
            config.provideFormatter = true;
          };

          vscode-html-language-server = {
            command = lib.getExe pkgs.nodePackages.vscode-html-languageserver-bin;
            args = ["--stdio"];
          };
          zig-language-server = {
            command = lib.getExe pkgs.zls;
          };

          # qml-lamguage-server = {
          # command = lib.getExe pkgs.kdePackages.qtdeclarative;
          # args = ["--stdio"];
          # conifg.provideFormatter = true;
          # };

          nil = {
            command = lib.getExe pkgs.nil;
            config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
          };
        };
      };
    };
  };
}
