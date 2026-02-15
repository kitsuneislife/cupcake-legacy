{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # -- SNOW MANAGED PACKAGES --
    # Add packages here via 'eclair install <pkg>'
    discord
    spotify
    # ---------------------------
  ];
}
