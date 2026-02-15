{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "mactahoe-kde-theme";
  version = "2024-02-15";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-kde";
    rev = "a915d3d8f18ae2d7d86e0f79c1cc44d93bb98bd4";
    sha256 = lib.fakeSha256;
  };

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/share
    
    # Install global theme (look and feel)
    if [ -d "lookandfeel" ]; then
      mkdir -p $out/share/plasma/look-and-feel
      cp -r lookandfeel/* $out/share/plasma/look-and-feel/
    fi
    
    # Install Aurorae themes (window decorations)
    if [ -d "aurorae" ]; then
      mkdir -p $out/share/aurorae/themes
      cp -r aurorae/* $out/share/aurorae/themes/
    fi
    
    # Install Kvantum theme
    if [ -d "Kvantum" ]; then
      mkdir -p $out/share/Kvantum
      cp -r Kvantum/* $out/share/Kvantum/
    fi
    
    # Install color schemes
    if [ -d "color-schemes" ]; then
      mkdir -p $out/share/color-schemes
      cp -r color-schemes/* $out/share/color-schemes/
    fi
    
    # Install Konsole themes
    if [ -d "konsole" ]; then
      mkdir -p $out/share/konsole
      cp -r konsole/* $out/share/konsole/
    fi
    
    # Install plasma themes
    if [ -d "plasma" ]; then
      mkdir -p $out/share/plasma/desktoptheme
      cp -r plasma/desktoptheme/* $out/share/plasma/desktoptheme/
    fi
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "MacTahoe theme for KDE Plasma desktop";
    homepage = "https://github.com/vinceliuice/MacTahoe-kde";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
