<div align="center">
  <h1>✦ Cupcake (Legacy) </h1>
  <p><strong>A modern, modular NixOS distribution</strong></p>
  <p>
    <em>KDE Plasma 6 + Declarative Config • macOS-inspired design • "Pancake" Desktop</em>
  </p>
  <p>🚧 <strong>STATUS: ABANDONED </strong> 🚧</p>
</div>

---

## What is Cupcake?

Cupcake is a NixOS-based Linux distribution focused on:

- **Modularity** — Toggle features on/off with a single command
- **Design** — macOS Tahoe-inspired theme (MacTahoe) running on KDE Plasma 6
- **Simplicity** — Manage your entire system through the `eclair` CLI
- **Stability** — Leveraging the robust NixOS Plasma 6 module
- **Declarative** — Entire desktop configured via code (`plasma-manager`)

## Stack

| Component | Technology |
|-----------|-----------|
| OS | NixOS (Flakes) |
| Desktop Environment | **KDE Plasma 6 ("Pancake")** |
| Config Manager | `plasma-manager` (Declarative) |
| Theme | MacTahoe (GTK + Icons) + Breeze Dark |
| Cursor | macOS BigSur |
| Font | Inter |
| Shell | Fish + Starship |

## Quick Start

```bash
# Enter the development shell
nix develop

# Build and test in a VM
just vm

# Apply to your system (Coming Soon)
eclair update
```

## Eclair CLI

```bash
eclair enable python        # Enable a feature
eclair disable nvidia       # Disable a feature
eclair install discord      # Add a package
eclair update               # Rebuild the system
eclair help                 # Keybind cheatsheet
```

## Project Structure

```
cupcake/
├── flake.nix              # Nix flake entry point (Inputs: NixOS, HM, Plasma-Manager)
├── flake.lock
├── justfile               # Dev commands (just vm, just clean-vm)
│
├── hosts/default/         # Host-specific config
│   ├── default.nix        # Main host configuration
│   ├── home.nix           # User config (Plasma settings here!)
│   └── features.nix       # Feature toggles
│
├── modules/               # NixOS modules
│   ├── apps/              # Application stack
│   ├── desktop/           # KDE Plasma 6 + Theme constants
│   └── drivers/           # Hardware drivers
│
└── pkgs/                  # Custom Nix packages
    ├── mactahoe-gtk-theme.nix
    └── mactahoe-icon-theme.nix
```

## Features

Toggle system features declaratively:

| Feature | Description |
|---------|-----------|
| `desktop.kde` | **KDE Plasma 6 Desktop** (Enabled) |
| `desktop.hyprland` | *Legacy/Removed* |
| `performance` | Kernel tweaks, I/O scheduler |
| `drivers.nvidia` | Nvidia proprietary drivers |

## License

MIT
