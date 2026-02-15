{ config, lib, pkgs, ... }:

{
  # -- CUPCAKE FEATURES --
  # This file is managed by 'eclair'. You can edit it manually, 
  # but 'eclair' commands will rewrite these values.

  cupcake = {
    # Core System
    system.performance.enable = true;
    system.security.enable = true;

    # Development
    dev.python.enable = true;
    dev.zsh.enable = false;
    dev.fish.enable = true;
    dev.rust.enable = false;
    
    # Base Apps
    apps.enable = true;
    dev.nodejs.enable = false;

    # Desktop
    desktop.kde.enable = true;
    
    # Drivers
    drivers.nvidia.enable = false;
  };
}
