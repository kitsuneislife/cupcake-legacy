{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.cupcake.desktop.kde;
  vicinae = pkgs.callPackage ../../pkgs/vicinae.nix {};
in
{
  options.cupcake.desktop.kde = {
    enable = lib.mkEnableOption "KDE Plasma 6 Desktop";
  };

  config = lib.mkIf cfg.enable {
    # ── Desktop Environment ──────────────────────
    services.desktopManager.plasma6.enable = true;

    # ── X Server ─────────────────────────────────
    # Even for Wayland sessions, some components may need this
    services.xserver.enable = true;

    # ── Display Manager (SDDM) ───────────────────
    services.displayManager.sddm.enable = true;
    # Enable Wayland for SDDM (allows Plasma Wayland sessions)
    services.displayManager.sddm.wayland.enable = true;
    
    # Set Plasma Wayland as default session
    services.displayManager.defaultSession = "plasma";
    
    # ── Graphics / Hardware ──────────────────────
    # Plasma 6 / Wayland requires this
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    # ── XDG Portals ──────────────────────────────
    # KDE handled automatically by desktopManager.plasma6
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    # ── System Packages ──────────────────────────
    environment.systemPackages = with pkgs; [
      # Standard KDE Apps are included by default with plasma6.enable
      # Adding useful extras:
      
      # Polkit Agent (KDE's agent is auto-started)
      kdePackages.polkit-kde-agent-1
      
      # Krohnkite - Dynamic tiling for KWin
      kdePackages.krohnkite
      
      # Clipboard
      wl-clipboard
      
      # Qt Wayland Support
      qt6.qtwayland
      qt5.qtwayland
    ];

    # ── Config Files ─────────────────────────────
    # Clean slate for now.
    environment.etc = {};
  };
}
