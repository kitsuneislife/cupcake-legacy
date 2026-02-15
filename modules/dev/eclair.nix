{ pkgs, ... }:

let
  eclairScript = pkgs.writeScriptBin "eclair" (builtins.readFile ../../scripts/eclair);
in
{
  environment.systemPackages = [ eclairScript ];
}
