{pkgs, ...}:{
  users.main = "dennkaii";

  # printers.enable = true;

  display = {
  #done both modules
    hyprland.enable = true;
    sddm.enable = true;

    #Not working for future refence
    #layout.enable = true;
  };

#wrote
  fonts.enable = true;

  gtk.enable = true;

#virtualmachine bs
  vm.enable = true;

  
  # bitwarden.enable = true;

  programs = {
    packages.enable = true;
    anyrun.enable = true;
    git.enable  = true;
    schizofox.enable = true;
    uchromium.enable = true;
    ags.enable = true;
    waybar.enable = true;
    # helix.enable = true;
    starship.enable = true;
    armcord.enable = true;
    mako.enable = true;
    
    # fish.enable = true;
    
    nu.enable = true;
    
    foot.enable = true;
    stylix.enable = true;

    games = {
      osu-lazer.enable = true;
      steam.enable = true;
      lutris.enable = true;

    };
    };

    services = {
      ssh.enable = true;
    };
}
