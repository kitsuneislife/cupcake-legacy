{ config, pkgs, mactahoe-gtk-theme, mactahoe-icon-theme, plasma-manager, ... }:

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
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

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
    # Nothing yet — system packages come from modules/apps
  ];

  # ── KDE Plasma Configuration ────────────────
  programs.plasma = {
    enable = true;
    
    # Workspace settings
    workspace = {
      # Use Breeze Dark theme as base
      lookAndFeel = "org.kde.breezedark.desktop";
      
      # Cursor theme
      cursor = {
        theme = "macOS-BigSur";
        size = 24;
      };
      
      # Wallpaper (you can customize this later)
      # wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Next/contents/images/1920x1080.png";
    };
    
    # Panel configuration
    panels = [
      # Bottom panel (taskbar)
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"  # Application launcher
          "org.kde.plasma.icontasks"  # Task manager
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
    
    # Shortcuts
    shortcuts = {
      "kwin"."Show Desktop" = "Meta+D";
      "org.kde.konsole.desktop"."_launch" = "Meta+Return";
    };
    
    # Enable config override (fully declarative)
    # overrideConfig = true;  # Uncomment to enforce strict declarative behavior
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
