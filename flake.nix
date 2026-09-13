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
            google-cloud-sdk
            turso-cli
            goose # golang database migration tool
          ];
          # The exec command replaces the currently running process with the command specified.
          # Add export of go installed binary. This fix issue of unknown binaries call of packages wich installed through go install
          shellHook = ''
            export GOPATH=$HOME/go
            export PATH=$GOPATH/bin:$PATH
            exec fish
          '';
        };
      };
    };
}
