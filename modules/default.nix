{ config, pkgs, lib, ... }:

{
  imports = [
    ./core/default.nix
    ./dev/default.nix
    ./desktop/default.nix
    ./drivers/default.nix
    ./apps/default.nix
  ];
}
