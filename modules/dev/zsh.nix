{ config, pkgs, lib, ... }:

{
  options.cupcake.dev.zsh.enable = lib.mkEnableOption "Zsh with Starship";

  config = lib.mkIf config.cupcake.dev.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake .";
        eclair = "sudo ./scripts/eclair";
      };
    };

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
    
    users.defaultUserShell = pkgs.zsh;
  };
}
