{
  pkgs,
  lib,
  config,
  ...
}: let
cfg = config.programs.waybar;
inherit(lib) mkIf mkEnableOption;
in {
  options.programs.waybar.enable = mkEnableOption "waybar";

  config = mkIf cfg.enable{

  hm = {

  
    programs.waybar = {
      enable = true;

      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          height = 40;
          modules-left = ["hyprland/workkspaces"];
          modules-center = ["hyprland/window" "clock"];
          modules-right  = ["wireplumber" "network" "battery" "tray"];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = false;
            format = "{icon}";
            format-icons = {
              urgent = "";
              active = "";
              default = "";
            };
          };

          "hyprland/window" = {
          max-lenght = 60;  
          };

          "tray" = {
            icon-size = 18;
            spacing = 10;
          };

          "wireplumber" = {
            scroll-step = 2;
            format = "{volume}%";
          };

          "network" = {
            format-wifi = "{essid} ";
          };

          battery = {
            bat = "BAT0";
            states = {
              good = 80;
              warning = 30;
              critical = 15;
            };
          };

          "clock" = {
            
          };
          
        };
      };


      style = ''
       * {
    border: none;
    border-radius: 16px;
    font-family: "Torus Nerd Font";
    font-size: 16px;
    min-height: 0;
}

tooltip {
  background: rgba(0,0,0,0.3);
}
tooltip*{
  background: rgba(0,0,0,0);
}

window#waybar {
    background: transparent;
}

#window {
    font-weight: bold;
}

#workspaces {
    padding: 0 5px;
}

#workspaces button {
    padding: 0 5px;
    background: transparent;
    color: white;
    border-top: 2px solid transparent;
}

#workspaces button.focused {
    color: transparent;
    border-top: 2px solid transparent;
}

#mode {
    background: transparent;
    border-bottom: 3px solid transparent;
}

#clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
    padding: 0 3px;
    margin: 0 2px;
}

#clock {
    font-weight: bold;
}

#battery {
}

#battery icon {
    color: red;
}

#battery.charging {
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: black;
    }
}

#battery.warning:not(.charging) {
    color: white;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#cpu {
}

#memory {
}

#network {
}

#network.disconnected {
    background: transparent;
}

#pulseaudio {
}

#pulseaudio.muted {
}

#mpris {
    color: rgb(102, 220, 105);
}

#tray {
} 
      '';

      
    };
  };
    
  };
}
