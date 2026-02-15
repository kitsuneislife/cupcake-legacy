{ lib, stdenvNoCC, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "mactahoe-gtk-theme";
  version = "2025-08-22";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-gtk-theme";
    rev = version;
    sha256 = "0yan1wlvkndv294p34g6b3yrwxq3y9f1ylr3rf5lq0rivzmga843";
  };

  dontBuild = true;

  # The repo ships pre-built tarballs in release/. Extract them directly
  # instead of running install.sh (which needs getent, sudo, xmllint, internet).
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    for tarball in release/MacTahoe-*.tar.xz; do
      tar -xf "$tarball" -C $out/share/themes/
    done
    runHook postInstall
  '';

  meta = with lib; {
    description = "macOS Tahoe theme for GTK desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-gtk-theme";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
