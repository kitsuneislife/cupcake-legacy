{ lib, stdenvNoCC, fetchFromGitHub, gtk3, hicolor-icon-theme, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "mactahoe-icon-theme";
  version = "2025-10-16";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-icon-theme";
    rev = version;
    sha256 = "0pck2z9nh3r65ssgnyrfjarffj3n30cji9li9wvm1gcwcwzghf6r";
  };

  nativeBuildInputs = [ gtk3 ];
  propagatedBuildInputs = [ hicolor-icon-theme ];

  dontDropIconThemeCache = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    bash install.sh -d $out/share/icons
    runHook postInstall
  '';

  meta = with lib; {
    description = "macOS Tahoe icon theme for Linux";
    homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
