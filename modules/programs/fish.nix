{
  pkgs,
  lib,
  config,
  ...
}: let 
cfg = config.programs.fish;
inherit(lib) mkEnableOption mkIf;

in {
  options.programs.fish = {
    enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    os = {
      users.defaultUserShell = pkgs.fish;
      programs.fish.enable = true;
    };

    hm = {
    
    programs.zellij = {
    enable = true;
    settings  = {
    # default_shell =  "fish";
      theme = "default";
      simplified_ui = true;
      default_layout = "compact";
            };
      #Not working the fish integration hm module
    # enableFishIntegration = true;
     # enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

      programs.fish = {
        enable = true;
         interactiveShellInit = ''
   set fish_greeting # Disable greeting

  if not set -q ZELLIJ                                                                                                                                                           
    if test "$ZELLIJ_AUTO_ATTACH" = "true"                                                                                                                                     
        zellij attach -c                                                                                                                                                       
    else                                                                                                                                                                       
        zellij                                                                                                                                                                 
    end                                                                                                                                                                        
                                                                                                                                                                               
    if test "$ZELLIJ_AUTO_EXIT" = "true"                                                                                                                                       
        kill $fish_pid                                                                                                                                                         
    end                                                                                                                                                                        
end
     '';
      };
    };
    
  };
}
