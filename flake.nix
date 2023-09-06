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
          rev = "b7216325c80ce1d5dcd0cfeff6971012d3ddab96";
          sha256 = "sha256-+7jxM1/A5ONcHhuKo4IjxTGazsKCAEIA6COYpAbLksw=";
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
