{ stdenv, coreutils }:

stdenv.mkDerivation {
  name = "wallpapers";
  version = "0.0.1";
  src = ./.;

  installPhase = ''
    ${coreutils}/bin/mkdir -p $out
    ${coreutils}/bin/mv *.jpg $out
  '';
}
