{
  description = "Nix devshells!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            fish
            go
            podman
          ];
# The exec command replaces the currently running process with the command specified.
          shellHook = ''
            exec fish
          '';
        };
      };
    };
}
