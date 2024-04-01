{
  config,
  lib,
  ...
}: {
  hm = lib.mkIf config.programs.discord.enable {
    xdg.configFile."vesktop/themes/Oxocarbon-theme.css".text = ''
          /**
       * @name Oxocarbon Dark
       * @author .mrtoby
       * @authorId idk
       * @version 0.1.0
       * @description 🎮 Oxocarbon Dark
       * @website idk
       * @invite idk
      */
          @import url("https://raw.githubusercontent.com/TobyBridle/arch-dots/main/vencord/settings/oxocarbon-theme.css");
    '';
  };
}
