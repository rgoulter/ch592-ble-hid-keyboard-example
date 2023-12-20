{
  description = "The CH592 HID_Keyboard EVT Example";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem [
      flake-utils.lib.system.x86_64-linux
    ] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells = {
        default = import ./shell.nix {
          inherit pkgs;
        };
      };
    });
}
