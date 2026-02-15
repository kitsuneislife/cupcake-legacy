# Justfile for Cupcake

# Update the system
update:
    @./scripts/eclair update

# Clean garbage
clean:
    @./scripts/eclair clean

# Enable a feature
enable feature:
    @./scripts/eclair enable {{feature}}

# Disable a feature
disable feature:
    @./scripts/eclair disable {{feature}}

# Show help
help:
    @./scripts/eclair help

# Install a package
install pkg:
    @./scripts/eclair install {{pkg}}

# Remove a package
remove pkg:
    @./scripts/eclair remove {{pkg}}

# Build VM (Use this if you need sudo/root to build)
build-vm:
    @echo "Building VM..."
    @nix build --extra-experimental-features "nix-command flakes" .#nixosConfigurations.default.config.system.build.vm
    @echo "Build complete! Run ./result/bin/run-cupcake-vm to start."

# Run System in VM (QEMU)
vm: build-vm
    @echo "Running VM..."
    @./result/bin/run-cupcake-vm

# Clean VM Disk (Fix permissions)
clean-vm:
    @sudo rm -f cupcake.qcow2
    @echo "VM disk removed. Ready to start fresh."

# Install Dotfiles manually (Fastfetch, etc)
dotfiles:
    @mkdir -p ~/.config/fastfetch
    @cp modules/apps/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
    @echo "Dotfiles installed!"
