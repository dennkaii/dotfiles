{
  pkgs,
  config,
  ...
}:let
#stolen from https://github.com/linuxmobile/kaku/blob/main/home/software/xdg.nix
browser = ["Schizofox"];
imageViewer = ["qimgv"];
Terminal = ["foot.desktop"];
videoPlayer = ["io.github.celluloid_player.Celluloid"];
audioPlayer = ["io.bassi.Amberol"];

 xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
        name = "${type}/${e}";
        value = program;
      })
      list);

  image = xdgAssociations "image" imageViewer ["png" "svg" "jpeg" "gif"];
  video = xdgAssociations "video" videoPlayer ["mp4" "avi" "mkv"];
  audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf"];
      "x-scheme-handler/element" = ["Element"];
      "text/html" = browser;
      "inode/directory" = ["org.gnome.Nautilus"];
      "text/plain" = ["Helix"];
      "x-scheme-handler/chrome" = ["chromium-browser"];
    }
    // image
    // video
    // audio
    // browserTypes);
in{
  config = {
    hm = {
    home.packages = with pkgs; [
      qimgv
      zathura
      celluloid
      amberol
      zathura
      ];


      xdg = {
        enable = true;
        # cacheHome = config.hm.home.HomeDirectoy + "/.local/cache";

        mimeApps = {
          enable = true;
          defaultApplications = associations;
        };

        userDirs = {
          enable = true;
          createDirectories = true;
          extraConfig = {
            # XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
          };
        };
      };
      
    };
    
  };
}
