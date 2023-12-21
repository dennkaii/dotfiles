{
  pkgs,
  osConfig,
  lib,
  ...
}: {
  osModules = [
    ./hardware-configuration.nix
  ];

  # inputs = { nixos-hardware.url = "github:NixOS/nixos-hardware/master";}

    os = {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    nixpkgs.config.allowUnfree = true;


    time.timeZone = "America/New_York";
    networking.hostName = "dennkaii";

    i18n.defaultLocale = "en_US.UTF-8";

   i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      
      initrd.luks.devices."luks-9a7885b4-ff8e-4350-a698-76c4a783e36c".device = "/dev/disk/by-uuid/9a7885b4-ff8e-4350-a698-76c4a783e36c";
    };


    networking = {
      networkmanager.enable = true;
    };

    hardware = {
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver # LIBVA_DRIVER_NAME=iHD
            vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
            vaapiVdpau
            libvdpau-va-gl

        ];
      };
    };

    security.rtkit.enable = true;

    services  = {
      # tlp = {enable = true;};
      # wireplumber = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        # alsa.support32bit = true;
        pulse.enable = true;
        jack.enable = true;
        # wireplumber = true;
      };

      #auto loign for user
       getty.autologinUser = "dennkaii";
    };
  };

  os.system.stateVersion = "23.05";
  hm.home.stateVersion = "23.05";
}
