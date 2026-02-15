{ lib
, python3Packages
, gobject-introspection
, gtk4
, libadwaita
, wrapGAppsHook4
}:

python3Packages.buildPythonApplication {
  pname = "cupcake-welcome";
  version = "0.1.0";
  format = "other";

  src = ./.;

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    libadwaita
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
  ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp cupcake-welcome.py $out/bin/cupcake-welcome
    chmod +x $out/bin/cupcake-welcome
    
    runHook postInstall
  '';
}
