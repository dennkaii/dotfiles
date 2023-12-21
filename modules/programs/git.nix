{
  pkgs,
  config,
  lib,
  ...
}:let

cfg = config.programs.git;
inherit(lib) mkEnableOption mkIf;

in {
  options.programs.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
  
     os.environment.systemPackages = with pkgs; [
      git
      gh
    ];

    hm.programs.git = {
      enable = true;
      userName = "dennkaii";
      userEmail = "githubdennkaii.q3i49@simplelogin.com";
    };
  };
}
