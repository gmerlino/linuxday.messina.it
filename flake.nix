{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ zola ];
      };

      packages.default = pkgs.stdenv.mkDerivation {
        pname = "linuxday-messina-website";
        version = "2025-10-25";
        src = ./.;
        nativeBuildInputs = [ pkgs.zola ];
        buildPhase = ''
          mkdir -p $out
          zola build --force --output-dir $out
        '';
      };
    }
  );
}
