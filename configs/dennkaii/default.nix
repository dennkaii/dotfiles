{pkgs, ...}:{
  users.main = "dennkaii";

  # printers.enable = true;

  display = {
  #done both modules
    hyprland.enable = true;
    sddm.enable = true;
    # greetd.enable = false;
  };

#wrote
  fonts.enable = true;

  
  # bitwarden.enable = true;

  programs = {
    packages.enable = true;
    anyrun.enable = true;
    git.enable  = true;
    schizofox.enable = true;
    ags.enable = true;
    # helix.enable = true;
    armcord.enable = true;
    fish.enable = true;
    foot.enable = true;
    
    };
}
