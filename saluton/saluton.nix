{ mkDerivation, base, scotty, stdenv }:
mkDerivation {
  pname = "saluton";
  version = "0.1.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [ base scotty ];
  description = "A soup to nuts example of deploying Haskell apps on NixOS using NixOps";
  license = stdenv.lib.licenses.unfree;
}
