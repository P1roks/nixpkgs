{
  lib,
  stdenv,
  fetchurl,
  cmake,
  freetype,
  gfortran,
  openssl,
  libnsl,
  motif,
  xorg,
  libxcrypt,
}:

stdenv.mkDerivation rec {
  version = "2024.06.12.0";
  pname = "cernlib";
  year = lib.versions.major version;

  src = fetchurl {
    urls = [
      "https://ftp.riken.jp/cernlib/download/${year}_source/tar/cernlib-cernlib-${version}-free.tar.gz"
      "https://cernlib.web.cern.ch/download/${year}_source/tar/cernlib-cernlib-${version}-free.tar.gz"
    ];
    hash = "sha256-SEFgQjPBkmRoaMD/7yXiXO9DZNrRhqZ01kptSDQur84=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = with xorg; [
    freetype
    gfortran
    openssl
    libnsl
    libX11
    libXaw
    libXft
    libXt
    libxcrypt
    motif
  ];

  setupHook = ./setup-hook.sh;

  meta = {
    homepage = "http://cernlib.web.cern.ch";
    description = "Legacy collection of libraries and modules for data analysis in high energy physics";
    platforms = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "x86_64-darwin"
    ];
    maintainers = with lib.maintainers; [ veprbl ];
    license = lib.licenses.gpl2;
  };
}
