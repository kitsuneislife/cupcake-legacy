{ pkgs, ... }:

let
  pname = "vicinae";
  version = "0.19.7"; 
  
  src = pkgs.fetchurl {
    url = "https://github.com/vicinaehq/vicinae/releases/download/v${version}/Vicinae-x86_64.AppImage";
    hash = "sha256-32XJloIehglnTndm6an4ss2fsP180yLIAauG6F+YX10="; 
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;
  
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/vicinae.desktop $out/share/applications/vicinae.desktop
    install -m 444 -D ${appimageContents}/vicinae.png \
      $out/share/icons/hicolor/512x512/apps/vicinae.png
    substituteInPlace $out/share/applications/vicinae.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';
}
