{ pkgs, inputs, ... }:

let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
  
  # Qt6 packages (these have QML modules directly in lib/qt-6/qml)
  qt6Deps = with pkgs.qt6; [
    qtbase
    qtdeclarative
    qt5compat
    qtwayland
    qtpositioning
    qtmultimedia
    qtsensors
    qtsvg
  ];

  # KDE packages — MUST use .unwrapped!
  # The default (wrapped) derivation only has nix-support/ with no QML files.
  # The actual QML modules live in the unwrapped derivation at lib/qt-6/qml/
  kdeDeps = with pkgs.kdePackages; [
    kirigami.unwrapped
    kitemmodels
    kdeclarative
    syntax-highlighting
    kiconthemes
  ];

  allDeps = qt6Deps ++ kdeDeps;

  # Build all QML search paths — NixOS packages may place modules in any of these
  qmlPaths = pkgs.lib.makeSearchPath "lib/qt-6/qml" allDeps;
  qtPluginPath = pkgs.lib.makeSearchPath "lib/qt-6/plugins" allDeps;
in
pkgs.symlinkJoin {
  name = "quickshell-wrapped";
  paths = [ quickshell ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/quickshell \
      --set QML_IMPORT_PATH "${qmlPaths}" \
      --set QML2_IMPORT_PATH "${qmlPaths}" \
      --set QT_PLUGIN_PATH "${qtPluginPath}" \
      --prefix XDG_DATA_DIRS : "${pkgs.lib.makeSearchPath "share" allDeps}" \
      --set QT_QPA_PLATFORM "wayland"
  '';
}
