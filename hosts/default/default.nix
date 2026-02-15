{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/desktop/theme.nix
    ./user-packages.nix
    # ./hardware-configuration.nix # TODO: Generate this on install
    ./features.nix
  ];

  # Basic system configuration
  system.stateVersion = "23.11"; # Did you read the comment?
  
  networking.hostName = "cupcake";
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features for Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System-wide Git Config (Safe Directory for builds)
  programs.git.config.safe.directory = "*";
  
  # Dconf (Required for GTK settings)
  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cupcake = {
    isNormalUser = true;
    description = "Cupcake User";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    initialPassword = "password";
    shell = pkgs.fish;
  };

  # Autologin for VM/Live testing
  # services.getty.autologinUser = "cupcake";

  # VM Resources (Generous)
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # 8GB
      cores = 4;
      sharedDirectories = {
        cupcake = {
          # CHANGE THIS if you rename the folder on your host machine!
          source = "/home/lukas/Documentos/Silvally";
          target = "/cupcake";
        };
      };
    };
  };
}
