{ config, pkgs, lib, ... }:

{
  imports = [
    ./python.nix
    ./zsh.nix
    ./fish.nix
    ./eclair.nix
    # ./rust.nix # TODO: Implement full module
    # ./nodejs.nix # TODO: Implement full module
  ];

  options.cupcake.dev = {
    rust.enable = lib.mkEnableOption "Rust development environment";
    nodejs.enable = lib.mkEnableOption "Node.js development environment";
  };

  config = {
    environment.systemPackages = with pkgs; [
      just
      git
    ];
  };
}
