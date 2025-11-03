# ./options.nix
{ lib, ... }:
with lib;
{
  options.myconfig = mkOption {
    type = types.submodule {
      options = {

        nixRevision = mkOption { type = types.str; };
        user = mkOption {
          type = types.submodule {
            options = {
              username = mkOption { type = types.str; };
              firstName = mkOption { type = types.str; };
              lastName = mkOption { type = types.str; };
              email = mkOption { type = types.str; };
            };
          };
        };

        localhost = mkOption {
          type = types.submodule {
            options = {
              hostname = mkOption { type = types.str; };
              system = mkOption {
                type = types.enum [ "aarch64-darwin" "x86_64-darwin" ];
              };
            };
          };
        };

        extraSystemModules = mkOption {
          type = types.listOf (types.submodule { });
          default = [ ];
          description = "A list of extra System modules to import into the configuration.";
        };

        extraHomeModules = mkOption {
          type = types.listOf (types.submodule { });
          default = [ ];
          description = "A list of extra home-manager modules to import into the configuration.";
        };

      };
    };
  };

  # Set defaults
  config.myconfig = {
    nixRevision = mkDefault "default-revision";
    user = {
      username = mkDefault "b";
      firstName = mkDefault "Ben";
      lastName = mkDefault "Lewis";
    };
    extraSystemModules = mkDefault [ ];
    extraHomeModules = mkDefault [ ];
  };
}
