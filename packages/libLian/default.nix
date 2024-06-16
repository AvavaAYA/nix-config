{
  stdenv ? (import <nixpkgs> {}).stdenv,
  fetchgit ? (import <nixpkgs> {}).fetchgit,
  pkgs ? import <nixpkgs> {},
}:
stdenv.mkDerivation {
  name = "libLian";

  src = ./.;

  nativeBuildInputs = [
    pkgs.musl
  ];

  buildPhase = ''
    gcc -c libLian.c -masm=intel -o libLian.o
    ar rcs libLian.a libLian.o
  '';

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    cp libLian.a $out/lib/
    cp libLian.h $out/include/
  '';

  meta = {
    description = "A small C library";
  };
}
