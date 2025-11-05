{
  description = "My Generic nix-darwin Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nix-darwin, ... }:
    let
      nixRevision = self.rev or self.dirtyRev or "default-revision";
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];

      systems = [ "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, ... }: {
        formatter = pkgs.nixpkgs-fmt;
      };

      flake.lib.mkHost = myconfig@{ localhost, ... }:
        let
          lib = inputs.nixpkgs.lib;

          # We forcibly execute the validation here, at the top of the function,
          # to enusre that the caller knows that the function arguments are invalid.
          # If we wait for the underlying modules to validate, the error source may
          # be unclear.
          validationCheck = lib.evalModules {
            modules = [
              "${self}/../modules/options.nix"
              {
                inherit myconfig;
              }
            ];
          };

          validated = validationCheck.config.myconfig;

        in
        {
          darwinConfigurations.${localhost.hostname} = nix-darwin.lib.darwinSystem {
            system = localhost.system;
            specialArgs = {
              inherit inputs;
            };
            modules = [
              {
                myconfig = validated // {
                  inherit nixRevision;
                };
              }
              inputs.home-manager.darwinModules.home-manager
              "${self}/../modules/options.nix"

              "${self}/../modules/darwin.nix"
              "${self}/../modules/base-system.nix"
              "${self}/../modules/git.nix"
              "${self}/../modules/home.nix"
              "${self}/../modules/iterm2.nix"
              "${self}/../modules/packages.nix"
              "${self}/../modules/zsh.nix"
            ] ++ myconfig.extraSystemModules;
          };
        };
    };
}
