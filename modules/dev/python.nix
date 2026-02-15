{ config, lib, pkgs, ... }:

let
  cfg = config.cupcake.dev.python;
in
{
  options.cupcake.dev.python = {
    enable = lib.mkEnableOption "Python development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      python3Packages.pip
      python3Packages.virtualenv
      black
      pylint
    ];
    
    environment.shellAliases = {
      py = "python3";
    };
  };
}
