{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
  qt6Packages,
}:
stdenv.mkDerivation {
  pname = "orbit";
  version = "0-unstable-18-10-2026";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "SunqDXX";
    repo = "OrbitLauncher";
    rev = "c0daaf73290e89ac3f53050fb486dc082d8f331b";
    hash = "sha256-Ix/vpvAmSDF60IPf20HyBtCoSYvLr2dpZ3NASeAPUc4=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    qt6Packages.wrapQtAppsHook
  ];

  buildInputs = [
    qt6Packages.qtbase
    qt6Packages.qtdeclarative
    qt6Packages.qtwayland
    kdePackages.layer-shell-qt
  ];

  meta = {
    homepage = "https://github.com/SunqdXX/OrbitLauncher";
    description = "Planet app launcher for Wayland. Standalone like wofi, or a module for any quickshell config";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = [lib.maintainers.choco98];
  };
}
