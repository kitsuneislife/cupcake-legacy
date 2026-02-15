{ config, pkgs, lib, ... }:

{
  options.cupcake.apps.enable = lib.mkEnableOption "Base Application Stack";

  config = lib.mkIf config.cupcake.apps.enable {
    environment.systemPackages = with pkgs; [
      # ── File Manager ──
      nautilus

      # ── Text Editor ──
      gnome-text-editor

      # ── Browser ──
      firefox

      # ── Development ──
      vscode

      # ── Media ──
      loupe                  # Image viewer
      mpv                    # Video player

      # ── System ──
      gnome-calculator       # Calculator
      gnome-control-center   # Settings
      fastfetch

      # ── Archive Manager ──
      file-roller

      # ── UX & Theming ──
      libadwaita

      # ── Custom Apps ──
      (pkgs.callPackage ../../pkgs/cupcake-welcome/default.nix {})
    ];

    # ── Hide unnecessary .desktop entries ──
    # KDE ships many apps we don't need visible in the launcher
    environment.etc = {};
  };
}
