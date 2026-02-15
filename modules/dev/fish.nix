{ config, pkgs, lib, ... }:

{
  options.cupcake.dev.fish.enable = lib.mkEnableOption "Fish Shell with Starship";

  config = lib.mkIf config.cupcake.dev.fish.enable {
    programs.fish = {
      enable = true;
      
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake .";
        eclair = "sudo eclair";
        qs = "quickshell -c /etc/xdg/quickshell/ii";
      };

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';
    };

    # Enable Starship for Fish
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
    
    # Ensure Fish is available in system packages
    environment.systemPackages = [ pkgs.fish ];

    # Set default shell for users who use this module (optional, handled in host config usually)
    # but we can ensure the package is there.
  };
}
