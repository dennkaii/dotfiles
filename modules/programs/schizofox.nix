{
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.programs.schizofox;
  inherit (lib) mkEnableOption mkIf;
in {
  options.programs.schizofox = {
    enable = mkEnableOption "schizofox";
  };

  config = mkIf cfg.enable {
    inputs = {schizofox.url = "github:schizofox/schizofox";};

    hmModules = [inputs.schizofox.homeManagerModules.default];

    hm = {
      #TODO declarative config
      programs.schizofox = {
        enable = true;

        security = {
          sanitizeOnShutdown = false;
          sandbox = true;
        };
        search = {
          removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
          addEngines = [
          ];
        };

        misc = {
          drm.enable = true;
          disableWebgl = false;
          startPageURL = "https://dawn-gilt.vercel.app";
          bookmarks = [
            {
              Title = "Noogle";
              URL = "https://noogle.dev";
              Placement = "toolbar";
            }
            {
              Title = "Nixpkgs Manual";
              URL = "https://nixos.org/manual/nixpkgs/stable";
              Placement = "toolbar";
            }
          ];
        };

        extensions = {
          simplefox.enable = true;
          enableDefaultExtensions = true;
          enableExtraExtensions = true;

          extraExtensions = let
            extensions = [
              {
                id = "1018e4d6-728f-4b20-ad56-37578a4de76";
                name = "flagfox";
              }
              {
                id = "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}";
                name = "auto-tab-discard";
              }
              {
                id = "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}";
                name = "refined-github-";
              }
              {
                id = "sponsorBlocker@ajay.app";
                name = "sponsorblock";
              }
              {
                id = "{74145f27-f039-47ce-a470-a662b129930a}";
                name = "clearurls";
              }
              {
                id = "smart-referer@meh.paranoid.pk";
                name = "smart-referer";
              }
              {
                id = "skipredirect@sblask";
                name = "skip-redirect";
              }
              {
                id = "DontFuckWithPaste@raim.ist";
                name = "dont-fuck-with-paste";
              }
              {
                id = "{d634138d-c276-4fc8-924b-40a0ea21d284}";
                name = "1password-x-password-manager";
              }
            ];

            mappedExtensions =
              map (extension: {
                name = extension.id;
                value = {
                  # installation_mode = "force_installed";
                  install_url = "https://addons.mozilla.org/firefox/downloads/latest/${extension.name}/latest.xpi";
                };
              })
              extensions;
          in
            lib.listToAttrs mappedExtensions;
        };
      };
    };
  };
}
##most of it is stolen from https://github.com/NotAShelf/nyx/blob/d407b4d6e5ab7f60350af61a3d73a62a5e9ac660/homes/notashelf/programs/graphical/apps/schizofox/default.nix#L15
##thanks :)

