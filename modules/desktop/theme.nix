{ config, lib, pkgs, ... }:

let
  mactahoe-gtk-theme = pkgs.callPackage ../../pkgs/mactahoe-gtk-theme.nix {};
  mactahoe-icon-theme = pkgs.callPackage ../../pkgs/mactahoe-icon-theme.nix {};
in
{
  # ── Fonts ──────────────────────────────────
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
    material-symbols
    google-fonts
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  # ── Theme Packages ────────────────────────
  environment.systemPackages = with pkgs; [
    # MacTahoe (primary macOS-style theme)
    mactahoe-gtk-theme
    mactahoe-icon-theme

    # Cursor
    apple-cursor
    
    # Fallback Icons
    adwaita-icon-theme
  ];

  # ── Environment Variables ──────────────────
  environment.sessionVariables = {
    # GTK Theme (MacTahoe with Breeze fallback)
    GTK_THEME = "MacTahoe-Dark";

    # Qt - Let KDE handle this
    # QT_QPA_PLATFORM = "wayland"; # Removed to prevent SDDM/Startup crashes
    
    # We don't need to force QT_QPA_PLATFORMTHEME="gtk3" on KDE
    # as it has its own integration.
  };

  # ── Icon Theme via XDG ─────────────────────
  # Set default icon theme system-wide
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=MacTahoe-Dark
    gtk-icon-theme-name=MacTahoe-Dark
    gtk-cursor-theme-name=macOS-BigSur
    gtk-cursor-theme-size=24
    gtk-font-name=Inter 11
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=MacTahoe-Dark
    gtk-icon-theme-name=MacTahoe-Dark
    gtk-cursor-theme-name=macOS-BigSur
    gtk-cursor-theme-size=24
    gtk-font-name=Inter 11
  '';
}
