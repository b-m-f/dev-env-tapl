{
  description = "Nix flake for Types and Programming Language Course. TU Berlin (2024)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (self: super: rec { }) ];
        pkgs = import nixpkgs {
          inherit overlays system;
          config.allowUnfree = true;
        };
        shell = {
          packages = [
            pkgs.agda
            pkgs.vscode-fhs
          ];
          shellHook = ''
            echo Run \`code\` in your terminal to start vs-code. Proceed to install agda extension.
          '';
        };
      in
      {
        nixpkgs.config.allowUnfree = true;

        devShells.default = pkgs.mkShell shell;
      }
    );
}
