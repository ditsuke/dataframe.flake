{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        name = "dataframe.cpp";
        src = pkgs.fetchFromGitHub {
          owner = "hosseinmoein";
          repo = "DataFrame";
          fetchSubmodules = true;
          rev = "2d32a0aac78d69992efe56a31443ebd6b1cf2e40";
          sha256 = "sha256-AKLZ6hbKDQSUi48pguFzWj4FQgCPlP3JQnPgsARx+is=";
        };
        patches = with pkgs ; [
          ./pc.in.patch
        ];
        buildInputs = with pkgs ; [ ];
        nativeBuildInputs = with pkgs; [
          cmake
        ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation
          {
            inherit name src buildInputs nativeBuildInputs patches;
          };
      }
    );
}
