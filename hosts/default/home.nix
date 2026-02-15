{ config, pkgs, mactahoe-gtk-theme, mactahoe-icon-theme, mactahoe-kde-theme, plasma-manager, ... }:

{
  # Import plasma-manager module
  imports = [ plasma-manager.homeModules.plasma-manager ];
  # ── Home Manager Meta ──────────────────────
  home.stateVersion = "23.11";
  home.username = "cupcake";
  home.homeDirectory = "/home/cupcake";

  # ── Git Configuration ──────────────────────
  programs.git = {
    enable = true;
    settings = {
      safe.directory = "/cupcake";
    };
  };

  # ── GTK Theme ──────────────────────────────
  gtk = {
    enable = true;

    theme = {
      name = "MacTahoe-Dark";
      package = mactahoe-gtk-theme;
    };

    iconTheme = {
      name = "MacTahoe-Dark";
      package = mactahoe-icon-theme;
    };

    cursorTheme = {
      name = "macOS-BigSur";
      size = 24;
    };

    font = {
      name = "Inter";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # ── Qt Theme ───────────────────────────────
  # Let Plasma handle Qt theming automatically
  # Setting qt.platformTheme breaks Plasma 6!
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  # };

  # ── Cursor (system-wide via Home Manager) ──
  home.pointerCursor = {
    name = "macOS-BigSur";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
  };

  # ── dconf (GNOME/GTK apps settings) ────────
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-name = "Inter 11";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
      gtk-theme = "MacTahoe-Dark";
      icon-theme = "MacTahoe-Dark";
      cursor-theme = "macOS-BigSur";
      cursor-size = 24;
    };
  };

  # ── Packages (user-level, not system) ──────
  home.packages = with pkgs; [
    # MacTahoe KDE theme
    mactahoe-kde-theme
  ];

  # ── KDE Plasma Configuration ────────────────
  # Minimal plasma-manager setup - let Plasma use its defaults
  programs.plasma = {
    enable = true;
    
    # Workspace settings
    workspace = {
      # Apply MacTahoe Dark global theme
      lookAndFeel = "com.github.vinceliuice.MacTahoe-Dark";
      
      cursor = {
        theme = "macOS-BigSur";
        size = 24;
      };
    };
    
    # Let Plasma create default panel
    # Shortcuts
    shortcuts = {
      "kwin"."Show Desktop" = "Meta+D";
      "org.kde.konsole.desktop"."_launch" = "Meta+Return";
    };
    
    # ── Krohnkite Configuration ─────────────────
    # Enable and configure Krohnkite tiling script
    configFile = {
      # Enable Krohnkite
      "kwinrc"."Plugins"."krohnkiteEnabled" = true;
      
      # Krohnkite default settings
      "kwinrc"."Script-krohnkite" = {
        # Tiling layout engine (default: Tile)
        layoutPerActivity = false;
        layoutPerDesktop = false;
        
        # Remove borders from tiled windows
        noTileBorder = true;
        
        # Screen gaps (pixels)
        screenGapBetween = 8;
        screenGapBottom = 8;
        screenGapLeft = 8;
        screenGapRight = 8;
        screenGapTop = 8;
        
        # Window gaps (pixels)
        tileLayoutGap = 8;
      };
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
