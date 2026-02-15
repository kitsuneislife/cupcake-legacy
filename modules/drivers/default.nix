{ config, lib, pkgs, ... }:

let
  cfg = config.cupcake.drivers;
in
{
  options.cupcake.drivers = {
    nvidia.enable = lib.mkEnableOption "Nvidia proprietary drivers";
    bluetooth.enable = lib.mkEnableOption "Bluetooth support" // { default = true; };
    audio.enable = lib.mkEnableOption "Pipewire audio" // { default = true; };
    wifi.enable = lib.mkEnableOption "Wifi/NetworkManager" // { default = true; };
  };

  config = lib.mkMerge [
    # --- Nvidia Configuration ---
    (lib.mkIf cfg.nvidia.enable {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        open = false; # Use proprietary
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    })

    # --- Audio (Pipewire) ---
    (lib.mkIf cfg.audio.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    })

    # --- Bluetooth ---
    (lib.mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      services.blueman.enable = true;
    })
    
     # --- Wifi / Networking ---
    (lib.mkIf cfg.wifi.enable {
      networking.networkmanager.enable = true;
      programs.nm-applet.enable = true; # Systray icon
    })
  ];
}
